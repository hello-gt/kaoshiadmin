<?php
namespace app\command\controller;
 
use think\Db;
use think\Controller;

/**
 * 命令行控制器
 *
 * @package app\index\controller
 */
class Index extends Controller
{
    public function test()
    {
        var_dump("hello world");
    }

    /**
     * 题目列表
     */
    public function questions()
    {
        $param = [
            "qid" => 3,
            "chid" => 6,
            "categories" => 2236,
            "knowledges" => "",
            "question_channel_type" => "",
            "difficult_index" => "",
            "exam_type" => "",
            "kid_num" => "",
            "grade_id" => "",
            "sort_field" => "time",
            "filterquestion" => 0,
            "content" => "",
            "page" => 2,
            "version_id" => "",
            "_" =>  microsecond(),
        ];

        // for ($i=1; $i <= 1000; $i++) { 
            // $param['page'] = $i;
            // $param['_'] = microsecond();
            // $res = http_curl("https://www.zujuan.com/api/question/list",$param,"GET");
            $res = file_get_contents("F:\kaoshiadmin\question.txt");
            $data = json_decode($res, true);
            if ($data['code'] == 0) {
                $result = $data['data']["questions"];
                
                foreach ($result as $val) {
                    //Question
                    $quest['question_id'] = $val['question_id']; 
                    $quest['question_type'] = $val['question_type']; 
                    $quest['question_channel_type'] = $val['question_channel_type']; 
                    $quest['channel_type_name'] = $val['channel_type_name']; 
                    $quest['title'] = $val['title']; 
                    $quest['question_text'] = $val['question_text']; 
                    $quest['options'] = json_encode($val['options']); 
                    $quest['answer_json'] = json_encode($val['answer_json']); 
                    $quest['answer_json_text'] = $val['answer_json_text']; 
                    $quest['answer'] = $val['answer']; 
                    $quest['answer_text'] = $val['answer_text']; 
                    $quest['explanation'] = $val['explanation']; 
                    $quest['ext'] = '人教版（新课程标准）/ 必修一'; 

                    Db::name('questions')->insert($quest);
                    
                    //Knowledge
                    $knowledge['question_id'] = $val['question_id'];
                    $knowledge['knowledge_name'] = $val['knowledge'];
                    $knowledge['t_knowledge'] = json_encode($val['t_knowledge']);
                    $knowledge['knowledge_path']  = json_encode($val['knowledge_path']);
                    $knowledge['knowledge_info']  = json_encode($val['knowledge_info']);
                    
                    Db::name('knowledge')->insert($knowledge);
                    
                    //Category
                    $category['question_id'] = $val['question_id'];
                    $category['category'] = json_encode($val['category']);
                    $category['category_path'] = json_encode($val['category_path']);
                    
                    Db::name('category')->insert($category);

                    //Source
                    $source['question_id'] = $val["question_id"];
                    $source['parent_id'] = $val["parent_id"];
                    $source['paperid'] = $val["paperid"];
                    $source['paper_title'] = $val["paper_title"];
                    $source['xd'] = $val["xd"];
                    $source['chid'] = $val["chid"];
                    $source['exam_type'] = $val["exam_type"];
                    $source['exam_name'] = $val["exam_name"];
                    $source['difficult_index'] = $val["difficult_index"];
                    $source['difficult_name'] = $val["difficult_name"];
                    $source['is_objective'] = $val["is_objective"];
                    $source['is_collect'] = $val["is_collect"];
                    $source['extra_file'] = $val["extra_file"];
                    $source['save_num'] = $val["save_num"];
                    $source['new_flag'] = $val["new_flag"];
                    $source['is_use'] = $val["is_use"];
                    $source['paper_source'] = $val["paper_source"];
                    $source['link_paper'] = $val["link_paper"];
                    $source['myanswer'] = $val["myanswer"];
                    $source['create_at'] = $val["create_at"];
                    $source['explain_sort_need'] = $val["explain_sort_need"];
                    $source['sub_explanation'] = $val["sub_explanation"];
                    $source['list'] = $val["list"];
                    
                    Db::name('source')->insert($source);
                    
                    //Paper
                    $paper['question_id'] = $val["question_id"];
                    $paper['paperid'] = $val['paperid'];
                    $paper['title'] = $val['paper_title'];

                    Db::name('paper')->insert($paper);
                   
                }
            } else {
                continue;
            }
            // $sleepDate = rand(30,100);
            // sleep($sleepDate);
        // }



    }

}