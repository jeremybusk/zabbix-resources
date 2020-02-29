#!/usr/bin/env python3
#
# apt install python3-requests
#
# or using virtual env
#
# apt insatll python3-venv
# python3 -m venv venv
# source venv/bin/activate
# pip install -U wheel pip
# pip install requests

# ./zabbix-create-screen-from-host.py --hostname "myhost.example.com" --screenname "myhost.example.com-screen" -u myadmin -p myadminpass

import math
import requests
import json
import argparse
import sys


def authenticate(url, username, password):
    payload = {'jsonrpc': '2.0',
              'method': 'user.login',
              'params': {
                  'user': username,
                  'password': password
              },
              'id': '2'
              }

    headers = {'Content-Type': 'application/json-rpc'}
    response = requests.post(url, data = json.dumps(payload), headers = headers);
    data = response.json()

    try:
        message = data['result']
    except:
        message = data['error']['data']
        print(message)
        quit()

    return data['result']


def getGraph(hostname, url, auth, graphtype, dynamic, columns):
    if (graphtype == 0):
        selecttype = ['graphid']
        select = 'selectGraphs'
    if (graphtype == 1):
        selecttype = ['itemid', 'value_type']
        select = 'selectItems'

    payload = {'jsonrpc': '2.0',
              'method': 'host.get',
              'params': {
                  select: selecttype,
                  'output': ['hostid', 'host'],
                  'searchByAny': 1,
                  'filter': {
                      'host': hostname
                  }
              },
              'auth': auth,
              'id': '2'
              }
    headers = {'Content-Type': 'application/json-rpc'}
    response = requests.post(url, data = json.dumps(payload), headers = headers);
    data = response.json()
    if len(data['result']) <= 0:
        # raise ValueError("Host has no metric items to graph. Does host exist?")
        sys.exit("Host has no metric items to graph. Does host exist?")
    graphs = []
    if (graphtype == 0):
        for i in data['result'][0]['graphs']:
            graphs.append(i['graphid'])

    if (graphtype == 1):
        for i in data['result'][0]['items']:
            if int(i['value_type']) in (0, 3):
                graphs.append(i['itemid'])

    graph_list = []
    x = 0
    y = 0

    for graph in graphs:
        graph_list.append({
            "resourcetype": graphtype,
            "resourceid": graph,
            "width": "500",
            "height": "100",
            "x": str(x),
            "y": str(y),
            "colspan": "1",
            "rowspan": "1",
            "elements": "0",
            "valign": "0",
            "halign": "0",
            "style": "0",
            "url": "",
            "dynamic": str(dynamic)
        })
        x += 1
        if x == columns:
            x = 0
            y += 1

    return graph_list


def screenCreate(url, auth, screen_name, graphids, columns):
    if len(graphids) % columns == 0:
        vsize = math.ceil( len(graphids) / columns )
    else:
        vsize = math.ceil( (len(graphids) / columns) + 1 )

    payload = {"jsonrpc": "2.0",
              "method": "screen.create",
              "params": [{
                  "name": screen_name,
                  "hsize": columns,
                  "vsize": vsize,
                  "screenitems": []
              }],
              "auth": auth,
              "id": 2
              }

    for i in graphids:
        payload['params'][0]['screenitems'].append(i)

    headers = {'Content-Type': 'application/json-rpc'}
    response = requests.post(url, data = json.dumps(payload), headers = headers);
    data = response.json()
    # data = json.loads(response.text)

    try:
        message = data['result']
    except:
        message =data['error']['data']

    print(json.dumps(message))


def main():

    parser = argparse.ArgumentParser(description='Create Zabbix screen from all of a host Items or Graphs.')
    # parser.add_argument('hostname', metavar='H', type=str,
    parser.add_argument('--url', required=False, type=str,
                        default='https://monitor.example.com/zabbix/api_jsonrpc.php',
                        help='Zabbix API to create screen from')
    parser.add_argument('-H', '--hostname', required=True, type=str,
                        help='Zabbix Host to create screen from')
    parser.add_argument('-u', '--username', required=False, type=str,
                        default='admin',
                        help='Zabbix API user to create screen from')
    parser.add_argument('-p', '--password', required=False, type=str,
                        default='admin',
                        help='Zabbix API userpass to create screen from')
    parser.add_argument('-s', '--screenname', required=True, type=str,
                        help='Screen name in Zabbix.  Put quotes around it if you want spaces in the name.')
    parser.add_argument('-c', dest='columns', type=int, default=3,
                        help='number of columns in the screen (default: 3)')
    parser.add_argument('-d', dest='dynamic', action='store_true',
                        help='enable for dynamic screen items (default: disabled)')
    parser.add_argument('-t', dest='screentype', action='store_true',
                        help='set to 1 if you want to create only simple graphs of items, no previously defined graphs will be added to screen (default 0)')

    args = parser.parse_args()
    hostname = args.hostname
    screen_name = args.screenname
    username = args.username
    password = args.password
    url = args.url
    columns = args.columns
    dynamic = (1 if args.dynamic else 0)
    screentype = (1 if args.screentype else 0)

    auth = authenticate(url, username, password)
    graphids = getGraph(hostname, url, auth, screentype, dynamic, columns)

    print("screen name: " + screen_name)
    print("total graph number: " + str(len(graphids)))

    screenCreate(url, auth, screen_name, graphids, columns)

if __name__ == '__main__':
    main()
