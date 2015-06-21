_get() {
    curl -X GET \
        -H "X-Parse-Application-Id: $PARSE_APP_ID" \
        -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" \
        -H "Content-Type: application/json" \
        -s \
        -G \
        $* \
    https://api.parse.com/1/classes/Host
}

_post() {
    curl -X POST \
        -H "X-Parse-Application-Id: $PARSE_APP_ID" \
        -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" \
        -H "Content-Type: application/json" \
        -s \
        $* \
    https://api.parse.com/1/classes/Host
}

_put() {
    objectId=$1
    shift
    curl -X PUT \
        -H "X-Parse-Application-Id: $PARSE_APP_ID" \
        -H "X-Parse-REST-API-Key: $PARSE_REST_KEY" \
        -H "Content-Type: application/json" \
        -s \
        $* \
    https://api.parse.com/1/classes/Host/$objectId
}

get_host_by_name() {
    test $# = 1 || {
        echo usage: get hostname
        return 1
    }
    hostname=$1
    _get --data-urlencode 'where={"name":"'$hostname'"}'
}

create_host() {
    test $# = 2 || {
        echo usage: post hostname ipv4
        return 1
    }
    hostname=$1
    ipv4=$2
    _post -d '{"name":"'$hostname'","ipv4":"'$ipv4'"}'
}

update_host() {
    test $# = 3 || {
        echo usage: put hostname ipv4 objectId
        return 1
    }
    hostname=$1
    ipv4=$2
    objectId=$3
    _put $objectId -d '{"name":"'$hostname'","ipv4":"'$ipv4'"}'
}

ip() {
    ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'
}
