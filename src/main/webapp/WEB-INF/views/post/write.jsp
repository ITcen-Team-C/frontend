<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<%@ page import ="store.itcen.community.postapi.entity.Category" %>
<link rel="shortcut icon" type="image/x-icon" href="${path}/pictures/monster.png">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/write.css"/>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/header_footer.css"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1, minimum-scale=1.0, maximum-scale=1.0, width=device-width">
    <title>write</title>

    <script src="${path}/js/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {

            $("#writeBTN").on("click", function (e) {
                const title = $("#title").val();
                const contents = $("#contents").val();
                const price = $("#price").val();
                const category = $("#category").val();
                const nickName = $("#nickName").val();
                const userId = $("#userId").val();

                console.log(title + " " + contents + " " + category + " " + price);

                // $.ajax({
                //     type: "POST",
                //     url: "/community/writeProcess",
                //     dataType: "json",
                //     contentType: "application/json; charset=UTF-8",
                //     data: JSON.stringify({
                //         'title': title,
                //         'contents': contents,
                //         'price': price,
                //         'category': category,
                //         'userId': userId
                //     }),
                //
                //     success: function (res) {
                //         // let boardContents = res.responseEntity.body.contents;
                //         // let boardJob = res.responseEntity.body.job;
                //         console.log("그냥 res : ", res);
                //
                //         console.log("JSON res : " + JSON.stringify(res));
                //
                //         // alert("JSON res 에서 꺼내기 : " + JSON.stringify(res.statusCode)); //undefined
                //         console.log("JSON res 에서 꺼내기 : " + JSON.stringify(res.category));
                //         console.log("JSON res 에서 꺼내기 : " + JSON.stringify(res.contents));
                //         console.log("JSON res 에서 꺼내기 : " + JSON.stringify(res.price));
                //
                //     } //success
                //
                // }); //ajax

                if (title==""||contents==""||price==""){
                    window.alert("내용을 전부 입력해주세요!")
                }
                else {
                    fetch("/community/post/writeProcess", {
                        method: "POST",
                        headers: {
                            "content-type": "application/json",
                            "accept": "application/json"
                        },
                        body: JSON.stringify({
                            'title': title,
                            'contents': contents,
                            'price': price,
                            'category': category,
                            'nickName': nickName,
                            'userId': userId
                        })
                    })
                        .then(response => response.json())
                        .then(result => {
                            console.log(result);
                            console.log(result.title);
                            window.location.href = "/post/1"
                        })
                }

                }); //onClick






        }); // onload
    </script>
</head>

<body>
<%@include file="/WEB-INF/views/post/header.jsp"%>

<div class="write-container">
<div class="write">
    <form id="writeForm">
<%-- ignore test--%>
        <select id="category" style="width: 150px;
                    height: 60px;
                    margin-top: 30px;
                    margin-left: 37px;
                    padding-left: 10px;
                    background-color: white;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;">
            <c:forEach items="${Category.values()}" var="category">
                <option value="${category}">${category.cat}</option>
            </c:forEach>
        </select>
        <input class="input-price" id="price" name="price" type="number" oninput="handleOnInput(this, 10)" placeholder="질문 해결 가격을 입력하세요!">
        <div class="title-contents">
            <input class="title-write" id="title" name="title" type="text" placeholder="제목" maxlength="50" > <br>

            <textarea class="contents" id="contents" name="contents" PLACEHOLDER="내용" maxlength="1000"></textarea> <br>
        </div>

        <input id="nickName" name="nickName" type="hidden" value="${nickname}">
        <input id="userId" name="userId" type=hidden value="${userId}">
        <input class="send-btn" id="writeBTN" type="button" value="작성">
    </form>
</div>
</div>
<%@include file="/WEB-INF/views/post/footer.jsp"%>

<script>
    // price input 제한
    function handleOnInput(el, maxlength) {
        if(el.value.length > maxlength)  {
            el.value = el.value.substr(0, maxlength);
            alert('가격 제한을 초과하였습니다.');
        }
        if (el.value < 0) {
            el.value = 0;
            alert("0원 이상의 가격을 입력해 주세요.");
        }
    }
</script>


</body>

</html>






