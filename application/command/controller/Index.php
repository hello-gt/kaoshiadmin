<?php
namespace app\command\controller;
 
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

        $param = [
            "xd" => 3,
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

        $res = http_curl("https://www.zujuan.com/api/question/list",$param,"GET");
        var_dump($res);die;

        /*$param = [
            "qid" => 43169547,
            "_" =>  microsecond(),
        ];
        $res = http_curl("https://www.zujuan.com/api/question/question-detail-access",$param,"GET"); */

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

        for ($i=1; $i <= 1000; $i++) { 
            $param['page'] = $i;
            $param['_'] = microsecond();
            // $res = http_curl("https://www.zujuan.com/api/question/list",$param,"GET");
            $res = file_get_contents("F:\kaoshiadmin\question.txt");
            $data = json_decode($res, true);
            if ($data['code'] == 0) {
                $questions = $data['data']["questions"];
                
                foreach ($questions as $question) {

                    //Question
                    $addQuestion['question_id'] = $question['question_id']; 
                    $addQuestion['question_type'] = $question['question_type']; 
                    $addQuestion['question_channel_type'] = $question['question_channel_type']; 
                    $addQuestion['channel_type_name'] = $question['channel_type_name']; 
                    $addQuestion['title'] = $question['title']; 
                    $addQuestion['question_text'] = $question['question_text']; 
                    $addQuestion['options'] = json_encode($question['options']); 
                    $addQuestion['answer_json'] = json_encode($question['answer_json']); 
                    $addQuestion['answer_json_text'] = $question['answer_json_text']; 
                    $addQuestion['answer'] = $question['answer']; 
                    $addQuestion['answer_text'] = $question['answer_text']; 
                    $addQuestion['explanation'] = $question['explanation']; 
                    $addQuestion['ext'] = '人教版（新课程标志）/ 必修一'; 

                    //Knowledge
                    $addKnowledge['question_id'] = $question['question_id'];
                    $addKnowledge['knowledge_name'] = $question['knowledge'];
                    $addKnowledge['t_knowledge'] = json_encode($question['t_knowledge']);
                    $addKnowledge['knowledge_path']  = json_encode($question['knowledge_path']);
                    $addKnowledge['knowledge_info']  = json_encode($question['knowledge_info']);

                    //Category
                    $addCategory['question_id'] = $question['question_id'];
                    $addCategory['category'] = json_encode($question['category']);
                    $addCategory['category_path'] = json_encode($question['category_path']);

                    //Source
                    $addSource["question_id"] = $question["question_id"];
                    $addSource["parent_id"] = $question["parent_id"];
                    $addSource["paperid"] = $question["paperid"];
                    $addSource["paper_title"] = $question["paper_title"];
                    $addSource["xd"] = $question["xd"];
                    $addSource["chid"] = $question["chid"];
                    $addSource["exam_type"] = $question["exam_type"];
                    $addSource["exam_name"] = $question["exam_name"];
                    $addSource["difficult_index"] = $question["difficult_index"];
                    $addSource["difficult_name"] = $question["difficult_name"];
                    $addSource["is_objective"] = $question["is_objective"];
                    $addSource["is_collect"] = $question["is_collect"];
                    $addSource["extra_file"] = $question["extra_file"];
                    $addSource["save_num"] = $question["save_num"];
                    $addSource["new_flag"] = $question["new_flag"];
                    $addSource["is_use"] = $question["is_use"];
                    $addSource["paper_source"] = $question["paper_source"];
                    $addSource["link_paper"] = $question["link_paper"];
                    $addSource["myanswer"] = $question["myanswer"];
                    $addSource["create_at"] = $question["create_at"];
                    $addSource["explain_sort_need"] = $question["explain_sort_need"];
                    $addSource["sub_explanation"] = $question["sub_explanation"];
                    $addSource["list"] = $question["list"];

                    //Paper
                    $addPaper["question_id"] = $question["question_id"];
                    $addPaper["paperid"] = $question['exit_paper']["pid"];
                    $addPaper["title"] = $question['exit_paper']["title"];

                    print_r($addPaper);die;
                }

            } else {
                continue;
            }

            $sleepDate = rand(30,100);
            sleep($sleepDate);
        }



    }

}