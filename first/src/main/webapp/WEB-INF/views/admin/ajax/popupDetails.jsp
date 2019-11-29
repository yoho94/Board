<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h2>${vo.title }</h2>
<br>
<figure class="image">
<img src="${vo.image }" style='width:100%'>
<figcaption>${vo.text }</figcaption>
</figure>
<a href="${vo.link }"></a>
높이 : ${vo.height}<br>
넓이 : ${vo.width}<br>
사용 여부 : ${vo.isUsing}<br>
작성자 : ${vo.write_id}<br>
수정자 : ${vo.mod_id}<br>
생성일 : ${vo.reg_date}<br>
수정일 : ${vo.mod_date}<br>
<input id="height" type="hidden" value="${vo.height}">
<input id="width" type="hidden" value="${vo.width}">