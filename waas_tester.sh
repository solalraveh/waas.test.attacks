echo "testing SQLi attack"
curl 10.96.153.213?id=%25%27+and+1%3D0+union+select+null%2C+table_name+from+information_schema.tables+%23&Submit=Submit
if test "$status" == "0"; then
   echo "No error code. Is WAAS configured properly?"
else
   echo "Test exited WAAS protection with error code $status"
fi

sleep 2

echo "testing XSS attack"
curl 10.96.153.213 -d "<script>alert(1);</script>"

echo "testing OS Command Injection attack"
curl 10.96.153.213 -d "?id=& echo aiwefwlguh &"

echo "testing Code Injection attack"
curl 10.96.153.213 -d "?arg=1; phpinfo()"

echo "testing Local File Inclusion"
curl 10.96.153.213 -d "8.8.8.8; cat /etc/passwd"

echo "testing Shellshock Protection"
curl 10.96.153.213 --referer "() { :; }; ping -c 3 209.126.230.74"

echo "testing Malformed HTTP Request attack"
curl -X GET 10.96.153.213 -d "echo 'hello'"

echo ""
