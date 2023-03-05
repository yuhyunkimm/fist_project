<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../layout/header.jsp" %>
<div class="mx-auto width-53 top-80">
    <div class="container my-5 py-5">   
        <div class="row">
            <div class="col-3 px-5" style="text-align: center;">
                <div class="mb-3">
                    <div class="fs-4">지원자 현황</div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="relative mb-3">
                            <div>
                                <img src="/images/default_profile.png" class="rounded" alt="Cinque Terre"
                                    style="max-width: 80px;">
                            </div>
                        </div>
                        <div>
                            <h6 class="card-subtitle text-muted">${compSession.compName}</h6>
                            <hr>
                            <ul class="nav flex-column nav-pills">
                                <li class="nav-item">
                                    <a class="nav-link a p-1 mb-1" aria-current="page" href="/comp/jobs">공고등록 / 수정</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link a p-1 mb-1 active" href="/comp/apply">지원자 현황</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link a p-1" href="/comp/resume/scrap">이력서 스크랩</a>
                                </li>
                                <hr>
                                <li class="nav-item">
                                    <a class="nav-link a p-1 mb-1" href="/comp/update" data-bs-toggle="modal"
                                        data-bs-target="#modal">정보수정</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link a p-1" href="/logout">로그아웃</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-9  my-4 pe-5">
                <div>
                    <h6><b>지원자 <div class="badge bg-secondary p-2 " style="font-weight: 700;">${aDtos.size()}</div></b></h6>
                    <table class="table" style="width:100%">
                        <thead>
                            <tr class="table-secondary" align=center>
                                <th scope="col" style="width:10%">No.</th>
                                <th scope="col" style="width:10%">이름</th>
                                <th scope="col" style="width:10%">이력서</th>
                                <th scope="col" style="width:25%">지원 공고</th>
                                <th scope="col" style="width:10%">경력</th>
                                <th scope="col" style="width:10%">상태</th>
                                <th scope="col" style="width:15%">응답</th>
                            </tr>
                        </thead>
                        <c:forEach items="${aDtos}" varStatus="status" var="aDto">
                            <tbody>
                                <tr align=center>
                                    <td>${status.count}</td>
                                    <td>${aDto.name}</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-sm"
                                         onclick="window.open('/resume/${aDto.resumeId}', '_blank', 'width=1920,height=1080,toolbars=no,scrollbars=no, resizable=no'); return false;">이력서</button>
                                    </td>
                                    <td><a href="/jobs/${aDto.jobsId}">${aDto.title}</a> </td>
                                    <td>${aDto.career}</td>
                                    <td>
                                        <div id="state-${aDto.applyId}">
                                            <div id="state-btn-${aDto.applyId}">
                                            <c:if test="${aDto.state == 0}" >
                                            <div class="badge bg-secondary p-2">대기중</div>
                                            </c:if>
                                            <c:if test="${aDto.state == 1}" >
                                            <div class="badge bg-success p-2">수락</div>
                                            </c:if>
                                            <c:if test="${aDto.state == -1}" >
                                            <div class="badge bg-danger p-2">거절</div>
                                            </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div id="response-${aDto.applyId}">
                                            <div class="dropdown" id="response-dropdown-${aDto.applyId}">
                                                <c:choose>
                                                   <c:when test="${aDto.state == 0 }">
                                                        <button type="button" class="btn btn-primary dropdown-toggle py-0" data-bs-toggle="dropdown">
                                                            답변하기
                                                        </button>
                                                   </c:when>
                                                
                                                   <c:otherwise>
                                                    <div class="badge bg-secondary p-2">답변완료</div>
                                                   </c:otherwise>
                                                </c:choose>

                                                <ul class="dropdown-menu">
                                                  <li><a class="dropdown-item" onclick="accept(`${principal.userId}`,`${aDto.applyId}`)">수락</a></li>
                                                  <li><a class="dropdown-item" onclick="deny(`${principal.userId}`,`${aDto.applyId}`)">거절</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalLabel">비밀번호 인증</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="mb-3">
                        <label for="inputPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="inputPassword" aria-describedby="passwordHelp"
                            onkeypress="if(event.keyCode=='13'){event.preventDefault(); checkPS(${compSession.compId});}">
                        <div id="passwordHelp" class="form-text">현재 비밀번호를 입력해 주세요.</div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary"
                    onclick="passwordCheckBtn(${compSession.compId})">Check</button>
            </div>
        </div>
    </div>
</div>
<script>
    function checkPS(cId) {
        passwordCheckBtn(cId);
    }

    const passwordInputEl = document.querySelector('#inputPassword')
    const modalEl = document.querySelector('#modal')

    modalEl.addEventListener('shown.bs.modal', function () {
        passwordInputEl.focus()
    })

    function passwordCheckBtn(cId) {

        let data = {
            compId: cId,
            password: $('#inputPassword').val()
        }

        $.ajax({
            type: "post",
            url: "/comp/passwordCheck",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            datatype: "json"
        }).done((res) => {
            location.href = "/comp/update";
        }).fail((err) => {
            alert(err.responseJSON.msg);
        });
    }
</script>
<%@ include file="../layout/footer.jsp" %>

