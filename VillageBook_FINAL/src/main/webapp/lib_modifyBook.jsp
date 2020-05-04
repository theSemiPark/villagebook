<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>도서 수정/삭제</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
th {
   width: 100px;
}

input {
   width: 600px;
}
</style>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple"
   alink="red">

   <header id="header">
      <div id="header_box">
         <%@ include file="/headers/libraryHeader.jsp"%>
      </div>
   </header>
   <br>

   <h2>도서 수정/삭제</h2>
   <br>
   <form action="lib_modifyBook.do" method="post" enctype="multipart/form-data">
      <table>
         <tr>
            <th>ISBN</th>
            <td><input type="text" name="isbn" value="${book.isbn }"   readonly /></td>
         </tr>
         <tr>
            <th>도서제목</th>
            <td><input type="text" name="bookname"
               value="${book.bookname }" required /></td>
         </tr>
         <tr>
            <th>저자</th>
            <td><input type="text" name="author" value="${book.author }" /></td>
         </tr>
         <tr>
            <th>출판사</th>
            <td><input type="text" name="publisher"
               value="${book.publisher }" /></td>
         </tr>
         <tr>
            <th>출판일</th>
            <td><input type="date" name="pdate" value="${book.pdate }" /></td>
         </tr>
         <tr>
            <th>장르</th>
            <td><input type="text" name="genre" value="${book.genre }" /></td>
         </tr>
         <tr>
            <th>보유 권수</th>
            <td><input type="text" name="havecnt" class="havecnt"
               value="${book.havecnt }" /></td>
         </tr>
         <tr>
            <th>대여 권수</th>
            <td><input type="text" name="rcnt" class="rcnt"
               value="${book.rcnt }" readonly /></td>
         </tr>
          <tr><th>업로드</th>
            <td>
            <div class="inputArea">
             <input type= "text" name="img" class="img" value="${book.img }" readonly />
            <input type="file" id="upload" name="uploadFile"/>
            <div class="select_img" ><img src=""  alt="이미지썸네일" style="width:100%; height:300px;"/></div>
            <script>
               $("#upload").change(function(){
                  if(this.files && this.files[0]){
                     var reader = new FileReader;
                     reader.onload = function(data){
                        $(".select_img img").attr("src", data.target.result).width(300);
                     }
                     reader.readAsDataURL(this.files[0]);
                  }
               });
         </script></div>
         </td>
         <tr>
            <td colspan="2" style="text-align: center;"><input
               type="button" class="mod" value="수정" style="width: 50px" /> 
               <script>
                  $(".mod").click(function(){
                     if($(".rcnt").val()>$(".havecnt").val()){
                        alert("보유하고 있는 권수는 현재 대여중인 권수보다 많아야 합니다.");
                     }else
                     //alert($(".rcnt").val());
                     //alert($(".havecnt").val());
                     $("form").submit();
                  });
               </script>
               <button type="button" class="del" style="width: 50px" >삭제</button>
               <script>
                  $(".del").click(function(){
                     $("form").attr("action", "lib_deleteBook.do");
                     $("form").submit();
                  });
               </script>
               </td>
         </tr>
         <c:forEach items="${bookList}" var="book">
         <tr>
            <td> <a   href="lib_modifyBook.do?isbn=${book.isbn }">${book.isbn }</a></td>
            <td>${book.bookname }</td>
            <td>${book.author }</td>
            <td>${book.publisher}</td>
            <td>${book.genre }</td>
            <td>${book.pdate }</td>
            <td>${book.img }</td>
         </tr>

      </c:forEach>
      </table>
   </form>
</body>
</html>