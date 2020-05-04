<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<title>도서등록</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
th{
   width:100px;
}
input{
   width: 600px;
}
</style>
<script>
    var upload = document.querySelector('#upload');
    var preview = document.querySelector('#preview');
 
    upload.addEventListener('change',function (e) {
        var get_file = e.target.files;
 
        var image = document.createElement('img');
 
        /* FileReader 객체 생성 */
        var reader = new FileReader();
 
        /* reader 시작시 함수 구현 */
        reader.onload = (function (aImg) {
            console.log(1);
 
            return function (e) {
                console.log(3);
                /* base64 인코딩 된 스트링 데이터 */
                aImg.src = e.target.result
            }
        })(image)
 
        if(get_file){
            /* 
                get_file[0] 을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 
                onload 에 설정했던 return 으로 넘어간다.
                이와 함게 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.
            */
            reader.readAsDataURL(get_file[0]);
            console.log(2);
        }
 
        preview.appendChild(image);
    })
</script>
</head>
<body>

   <header id="header">
      <div id="header_box">
         <%@ include file="/headers/libraryHeader.jsp" %>
      </div>
   </header><br>
   
   <h1>도서등록</h1>
   <hr>
   <form action="lib_newBook.do" method="post" enctype="multipart/form-data">
      <table>
      <tr><th>ISBN</th>
            <td><input type="text" name="isbn"  value="${user.isbn }" /></td>
      </tr>
      <tr><th>도서제목</th>
            <td><input type="text" name="bookname"  value="${user.bookname }" /></td>
      </tr>
      <tr><th>저자</th>
            <td><input type="text" name="author"  value="${user.author }" /></td>
      </tr>
      <tr><th>출판사</th>
            <td><input type="text" name="publisher"  value="${user.publisher }" /></td>
      </tr>
      <tr><th>출판일</th>
            <td><input type="date" name="pdate"  value="${user.pdate }" /></td>
      </tr>
      <tr><th>장르</th>
            <td><input type="text" name="genre"  value="${user.genre }" /></td>
      </tr>
      <tr><th>업로드</th>
            <td>
            <div class="inputArea">
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
      </tr>
      <tr>
            <td colspan="2" style="text-align:center;">
            <input type="submit" value="등록" style="width:50px"/> <input type="reset" value="초기화" style="width:50px"/>
            </td>
         </tr>
        </table>
      </form>
      
      
      
      <div id='preview'>
        <!-- 미리보기 공간 -->
    </div>
    
</body>
</html>