<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * 网络请求
 * @param string $url 请求地址
 * @param string $param 请求参数  xxx=xxx&xxx=xxx
 * @param string $request_method 请求方法
 * @param string $aHeader header头
 * @return string|boolean
 */
function http_curl($url, $param='', $request_method='POST', $aHeader = array()){

    $aHeader = array('User-Agent:Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36');
    $cookie = '53gid2=10334500908017; 53revisit=1614565765449; 53kf_72203385_from_host=www.zujuan.com; 53kf_72203385_land_page=https%253A%252F%252Fwww.zujuan.com%252F; kf_72203385_land_page_ok=1; 53uvid=1; onliner_zdfq72203385=0; visitor_type=old; device=310bdaba05b30bb632f66fde9bf3e2b91ebc4d607c250c2e1a1d9e0dfb900f01a%3A2%3A%7Bi%3A0%3Bs%3A6%3A%22device%22%3Bi%3A1%3BN%3B%7D; BAIDU_SSP_lcr=https://www.baidu.com/link?url=279rbeRnSKwKKoS32E8eKTeUbHwNH2P5HwoAsuIIigfrh9p8fKwlmXXvvAqD5mSo&wd=&eqid=b6f3269e00005fc100000003603c5180; Hm_lvt_6de0a5b2c05e49d1c850edca0c13051f=1614565765,1614565861; _identity=b6736a3bc360649ba8b0beb01fc8295eeb0cc69a328d3fd4f242161070edb2b3a%3A2%3A%7Bi%3A0%3Bs%3A9%3A%22_identity%22%3Bi%3A1%3Bs%3A50%3A%22%5B3670717%2C%22b9ef6a8d4abc994915a6500c5729b6ac%22%2C86400%5D%22%3B%7D; _csrf=385b597e7d1e331d86738ee397d2f01f62de708dd6ff6acb32e6d63c32b90d94a%3A2%3A%7Bi%3A0%3Bs%3A5%3A%22_csrf%22%3Bi%3A1%3Bs%3A32%3A%22fZ-QBfe1doQv8Af08sqp9oAaqtdOXfEY%22%3B%7D; jump_url=004a78ee56f07e58ba41e60a4a1e19a93e43a6af115c13bca6f35356b9297e6ba%3A2%3A%7Bi%3A0%3Bs%3A8%3A%22jump_url%22%3Bi%3A1%3Bs%3A53%3A%22https%3A%2F%2Fwww.zujuan.com%2Fquestion%2Fdetail-43020535.shtml%22%3B%7D; _sync_login_identity=b511b93833bf79568f5699ae4e9923c39285e622057069f6df3eda10632ee020a%3A2%3A%7Bi%3A0%3Bs%3A20%3A%22_sync_login_identity%22%3Bi%3A1%3Bs%3A50%3A%22%5B3670717%2C%221_0I9OAsphD3F5DWW_mJym5PrcrQkDgW%22%2C86400%5D%22%3B%7D; 53kf_72203385_keyword=https%3A%2F%2Fpassport.zujuan.com%2F; global_xd_chid=%7B%22xd%22%3A%223%22%2C%22chid%22%3A%226%22%7D; chid=edb26e513d9f6c5b27f481f2930c0f29b22e216a8813fde3b300c0c1883d7d9ba%3A2%3A%7Bi%3A0%3Bs%3A4%3A%22chid%22%3Bi%3A1%3Bi%3A3%3B%7D; xd=75519cb9f2bf90d001c0560f5c40520062a60ada9cb38350078f83e04ee38a31a%3A2%3A%7Bi%3A0%3Bs%3A2%3A%22xd%22%3Bi%3A1%3Bi%3A2%3B%7D; Hm_lpvt_6de0a5b2c05e49d1c850edca0c13051f=1614656559; PHPSESSID=hir12dp949emfv5bba5r79ig75';
    $ch = curl_init();//初始化curl
    curl_setopt($ch, CURLOPT_URL, $url);//抓取指定网页
    curl_setopt($ch, CURLOPT_HEADER, 0);//设置header
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST , false);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $aHeader);
    curl_setopt ($ch, CURLOPT_COOKIE , $cookie );
    if($request_method == 'POST'){
        curl_setopt($ch,CURLOPT_POST, 1);
        curl_setopt($ch,CURLOPT_POSTFIELDS, $param);
    }else if($request_method == 'GET'){
        if(is_array($param)){
            $str_p = '';
            foreach($param as $k => $v){
                if(empty($str_p)){
                    $str_p .= "?{$k}={$v}";
                }else{
                    $str_p .= "&{$k}={$v}";
                }
            }
            curl_setopt($ch, CURLOPT_URL, $url.$str_p);//抓取指定网页
        }
    }else{
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
    }

    $data = curl_exec($ch);//运行curl
    if(curl_errno($ch)){
        return false;
    }
    curl_close($ch);
    return $data;
}

// 返回当前的毫秒时间戳
function microsecond()
{
    $t = explode(" ", microtime());
    $microsecond = round(round($t[1].substr($t[0],2,3)));
    return $microsecond;
}