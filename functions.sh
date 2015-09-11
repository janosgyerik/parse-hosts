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
    test $# = 3 || {
        echo usage: post hostname ipv4 mac
        return 1
    }
    hostname=$1
    ipv4=$2
    mac=$3
    _post -d '{"name":"'$hostname'","ipv4":"'$ipv4'","mac":"'$mac'"}'
}

update_host() {
    test $# = 4 || {
        echo usage: put hostname ipv4 mac objectId
        return 1
    }
    hostname=$1
    ipv4=$2
    mac=$3
    objectId=$4
    _put $objectId -d '{"name":"'$hostname'","ipv4":"'$ipv4'","mac":"'$mac'"}'
}
