IP_ADDR=`ifconfig | awk -F':' '/inet addr/ && NR < 8{print $2}' | cut -d' ' -f1`

cat > /etc/shadowsocks.json << EOF
{
    "server":"$IP_ADDR",
    "port_password":{
         "8888":"shadowsocks",
         "9999":"shadowsocks"
         },
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":false,
    "workers":1
}
EOF

cat >> /etc/rc.local << EOF
ssserver -c /etc/shadowsocks.json -d start
EOF

ssserver -c /etc/shadowsocks.json -d start
if [ $? -eq 0 ]
then
    echo "shadowsocks已启动..."
else
    echo "shadowsocks启动异常..."
fi

echo "
    =========================[ shadowsocks command ]==========================
    |  启动shadowsocks服务: ssserver -c /etc/shadowsocks.json -d start        |
    |  关闭shadowsocks服务: ssserver -c /etc/shadowsocks.json -d stop         |
    |  重启shadowsocks服务: ssserver -c /etc/shadowsocks.json -d restart      |
    ==========================================================================

    =========================[    win_turn 提醒您   ]==========================
    |  ip地址:   $IP_ADDR                                                     |
    |  端 口1:   8888                                                         |
    |  密 码1:   shadowsocks                                                  |
    |  端 口2:   9999                                                         |
    |  密 码2:   shadowsocks                                                  |
    ==========================================================================
"