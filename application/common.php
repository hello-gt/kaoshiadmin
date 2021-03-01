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
    $ch = curl_init();//初始化curl
    curl_setopt($ch, CURLOPT_URL, $url);//抓取指定网页
    curl_setopt($ch, CURLOPT_HEADER, 0);//设置header
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST , false);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $aHeader);

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