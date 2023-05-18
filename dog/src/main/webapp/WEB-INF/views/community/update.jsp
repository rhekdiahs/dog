<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중앙 컨텐츠 시작 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="main-page">
	<h2>글수정</h2>
	<form:form action="update.do" id="update_form" modelAttribute="communityVO" enctype="multipart/form-data">
		<form:hidden path="lf_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="lf_title">제목</label>
				<form:input path="lf_title"/>
				<form:errors path="lf_title" cssClass="error-color"/>
			</li>
			<li>
				<label for="lf_content">내용</label>
				<form:textarea path="lf_content"/>
				<form:errors path="lf_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#lf_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script> 
			</li>
			<li>
				<label for="upload">파일업로드</label> <!-- 이미지 말고도 다 가능 -->
				<input type="file" name="upload" id="upload">
				<c:if test="${!empty communityVO.lf_imgsrc}">
				<div id="file_detail">
					(${communityVO.lf_imgsrc})파일이 등록되어 있습니다.
					<input type="button" value="파일삭제" id="file_del">
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteFile.do',
									data:{lf_num:${communityVO.lf_num}},
									type:'post',
									dataType:'json',
									success:function(param){
										if(param.result == "logout"){
											alert('로그인 후 사용하세요!');
										}else if(param.result == 'success'){
											$('#file_detail').hide();
										}else{
											alert('파일 삭제 오류 발생');
										}
									},
									error:function(){
										alert('네트워크 오류 발생');
									}
								});
							}
						});
					});
				</script>
				</c:if>
			</li>
		</ul>
		<div class="align-center">
			<form:button>수정</form:button>
			<input type="button" value="상세정보" onclick="location.href='detail.do?lf_num=${communityVO.lf_num}'">
		</div>
	</form:form>
</div>
<!-- 중앙 컨텐츠 끝 -->