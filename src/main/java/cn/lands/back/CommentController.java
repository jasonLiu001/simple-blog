/**
 * Copyright (c) 2015-2016,  Jason(522914767@qq.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package cn.lands.back;

import java.util.Date;

import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.lands.BaseController;
import cn.lands.IConstants;
import cn.lands.Parameters;
import cn.lands.ResConsts;
import cn.lands.model.Blog;
import cn.lands.model.Comment;
import cn.lands.utils.KeyUtils;

/**
 *
 *
 * @author Jason
 * @version 1.0
 * @date 2016年11月2日
 */
public class CommentController extends BaseController {

	
	public void index(){
		Integer pageNum = getParaToInt(IConstants.PAGE_NUM);
		if(pageNum == null){
			pageNum = 1;
		}
		Integer pageSize = getParaToInt(IConstants.PAGE_SIZE);
		if(pageSize == null){
			pageSize = Parameters.DEFAULT_PAGE_SIZE;
		}
		Integer check  = getParaToInt("check");
		if(check == null){
			check = 0;
		}
		// 查询数据
		Page<Record> data = Comment.paginate(pageNum, pageSize,check);
		// 渲染结果
		render(ResConsts.Code.SUCCESS, null, data);
	}
	
	public void reply(){
		Comment comment = new Comment();
		String blogID = getPara("qingID");
		if(StrKit.isBlank(blogID)){
			render(ResConsts.Code.FAILURE, "评论所属ID不能为空");
			return;
		}
		String content = getPara("content");
		if(StrKit.isBlank(content)){
			render(ResConsts.Code.FAILURE, "评论内容不能为空");
			return;
		}
		String parent = getPara("parent");
		
		comment.setContent(content);
		comment.setBlogID(blogID);
		comment.setEmail(IConstants.EMAIL);
		comment.setNickname(IConstants.AUTHOR);
		comment.setId(KeyUtils.getUUID());
		comment.setLikeNum(0);
		comment.setHateNum(0);
		comment.setReplyNum(0);
		comment.setShareNum(0);
		comment.setParent(parent);
	    comment.setHeadURL("author.jpg");
	    comment.setCheck(1);
		comment.setCdate(new Date(System.currentTimeMillis()));
		
		if(comment.save()) {
			if(!IConstants.SPCMT_DNT.equals(blogID) && !IConstants.SPCMT_MSG.equals(blogID)){
				Blog blog = Blog.findById(blogID,"id,commentNum");
				blog.setCommentNum(blog.getCommentNum() + 1);
				blog.update();
			}
			render(ResConsts.Code.SUCCESS,"发表成功");
		} else {
			render(ResConsts.Code.FAILURE,"发表失败");
		}
	}
	
	public void get(){
		String id = getPara("id");
		Object data = Comment.dao.findById(id);
		if(data == null){
			render(ResConsts.Code.FAILURE, "记录不存在");
		} else {
			render(ResConsts.Code.SUCCESS, "", data);
		}
	}
	
	
	public void edit() {
		Comment comment = getModel(Comment.class,"comment");
		comment.setCheck(1);
		if(comment.update()){
			render(ResConsts.Code.SUCCESS,"保存成功");
		} else {
			render(ResConsts.Code.FAILURE,"保存失败");
		}
	}
}
