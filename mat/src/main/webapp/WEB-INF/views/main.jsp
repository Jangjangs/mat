<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>

				<!-- Main -->
					<div id="main">

						<!-- Featured Post -->
							<article class="post featured">
								

								<h2 style="text-align:center">주변 맛집</h2>
						<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
				<button type="button" class="btn btn-lg btn-primary"
				id="getMyPositionBtn" onclick="getCurrentPosBtn()">내 주변 맛집</button>
				<button type="button" id="setMyPosition" onclick="getCurrentPosByPickBtn()">검색으로 위치찾기</button>
			</div>
				<div>
				<form onsubmit="return false;">
					<input  type="hidden" value="맛집" id="keyword" size="15">
					<!-- <button type="button" onclick="keywordSearch()">검색하기</button> -->
				</form>
			  	</div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
       
    </div>
</div>
								
							</article>
						<!-- Posts -->
							<section class="posts">
								<article>
									<header>
										<a href="paldo/gyeonggi" style="font-size:2rem" >
											<span>경기도</span>
											<img src="/resources/images/gyeonggi.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/gyeongbuk" style="font-size:2rem" >
											<span>경상북도</span>
											<img src="/resources/images/gyeongbuk.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								
								</article>
								<article>
									<header>
										<a href="paldo/chungcheong" style="font-size:2rem" >
											<span>충청도</span>
											<img src="/resources/images/chungcheong.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/jeonla" style="font-size:2rem" >
											<span>전라도</span>
											<img src="/resources/images/jeonla.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/gyeonggi" style="font-size:2rem" >
											<span>경기도</span>
											<img src="/resources/images/gyeonggi.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/gyeonggi" style="font-size:2rem" >
											<span>경기도</span>
											<img src="/resources/images/gyeonggi.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/gyeonggi" style="font-size:2rem" >
											<span>경기도</span>
											<img src="/resources/images/gyeonggi.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								<article>
									<header>
										<a href="paldo/gyeonggi" style="font-size:2rem" >
											<span>경기도</span>
											<img src="/resources/images/gyeonggi.png" style="width:100%; height:100%"></img>
										</a>
									</header>
								</article>
								
							</section>

					

					</div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=13bb140364bb4ad34ae43c1d05a18ce5&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(36.039424, 129.3640706), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
	map.setMinLevel(1);
	map.setMaxLevel(3);
var currentPos;

function naverSearch(placeName){
	
	var name = placeName.replace(' ', '+');
	
	return 'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='+name;
}

function keywordSearch(){
	 var keyword = $('#keyword').val();
	 var markers = [];
	 
	 // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	    // 장소 검색 객체를 생성합니다
	    var ps = new kakao.maps.services.Places(map);

	    // 검색 옵션 객체
	    
	    var searchOption = {
	        location: currentPos,
	        radius: 1000,
	    };

	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	   ps.keywordSearch(keyword,placesSearchCB,searchOption);

	    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	    function placesSearchCB(data, status, pagination) {
	        if (status === kakao.maps.services.Status.OK) {

	            // 정상적으로 검색이 완료됐으면
	            // 검색 목록과 마커를 표출합니다
	            displayPlaces(data);

	            // 페이지 번호를 표출합니다
	            displayPagination(pagination);

	        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	            alert('검색 결과가 존재하지 않습니다.');
	            return;

	        } else if (status === kakao.maps.services.Status.ERROR) {

	            alert('검색 결과 중 오류가 발생했습니다.');
	            return;

	        }
	    }

	 // 검색 결과 목록과 마커를 표출하는 함수입니다
	    function displayPlaces(places) {

	        var listEl = document.getElementById('placesList'), 
	        menuEl = document.getElementById('menu_wrap'),
	        fragment = document.createDocumentFragment(), 
	        bounds = new kakao.maps.LatLngBounds(), 
	        listStr = '';
	        
	        // 검색 결과 목록에 추가된 항목들을 제거합니다
	        removeAllChildNods(listEl);

	        // 지도에 표시되고 있는 마커를 제거합니다
	        removeMarker();
	        
	        for ( var i=0; i<places.length; i++ ) {

	            // 마커를 생성하고 지도에 표시합니다
	            var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	                marker = addMarker(placePosition, i), 
	                itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

	            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	            // LatLngBounds 객체에 좌표를 추가합니다
	          	   bounds.extend(currentPos);

	            // 마커와 검색결과 항목에 mouseover 했을때
	            // 해당 장소에 인포윈도우에 장소명을 표시합니다
	            // mouseout 했을 때는 인포윈도우를 닫습니다
	            (function(marker, title) {
	                kakao.maps.event.addListener(marker, 'mouseover', function() {
	                    displayInfowindow(marker, title);
	                });

	                kakao.maps.event.addListener(marker, 'mouseout', function() {
	                    infowindow.close();
	                });

	                itemEl.onmouseover =  function () {
	                    displayInfowindow(marker, title);
	                };

	                itemEl.onmouseout =  function () {
	                    infowindow.close();
	                };
	            })(marker, places[i].place_name);

	            fragment.appendChild(itemEl);
	        }

	        // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	        listEl.appendChild(fragment);
	        menuEl.scrollTop = 0;

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        //map.setBounds(bounds);
	    }

	    // 검색결과 항목을 Element로 반환하는 함수입니다
	    function getListItem(index, places) {

	        var el = document.createElement('li'),
	        itemStr = '<img src="/resources/images/map_marker_icon.png" ></img>' + 
	                    '<div class="info">' +
	                    ' <a href="'+naverSearch(places.place_name)+'" target="_blank" title="네이버검색"> '+
	                    '   <h5>' + places.place_name + '</h5>';

	        if (places.road_address_name) {
	            itemStr += '    <span>' + places.road_address_name + '</span>' +
	                        '   <span class="jibun gray">' +  places.address_name  + '</span>';
	        } else {
	            itemStr += '    <span>' +  places.address_name  + '</span>'; 
	        }
	                     
	          itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                    '</div>';           

	        el.innerHTML = itemStr;
	        el.className = 'item';

	        return el;
	    }

	    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	    function addMarker(position, idx, title) {
	        var imageSrc = '/resources/images/map_marker_icon.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	            imgOptions =  {
	                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	            },
	            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	                marker = new kakao.maps.Marker({
	                position: position, // 마커의 위치
	                image: markerImage 
	            });
	        
	        marker.setMap(map); // 지도 위에 마커를 표출합니다
	        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	        return marker;
	    }

	    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
	    function removeMarker() {
	        for ( var i = 0; i < markers.length; i++ ) {
	            markers[i].setMap(null);
	        }   
	        markers = [];
	    }

	    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	    function displayPagination(pagination) {
	        var paginationEl = document.getElementById('pagination'),
	            fragment = document.createDocumentFragment(),
	            i; 

	        // 기존에 추가된 페이지번호를 삭제합니다
	        while (paginationEl.hasChildNodes()) {
	            paginationEl.removeChild (paginationEl.lastChild);
	        }

	        for (i=1; i<=pagination.last; i++) {
	            var el = document.createElement('a');
	            el.href = "javascript:;";
	            el.innerHTML = i;

	            if (i===pagination.current) {
	                el.className = 'on';
	            } else {
	                el.onclick = (function(i) {
	                    return function() {
	                        pagination.gotoPage(i);
	                    }
	                })(i);
	            }

	            fragment.appendChild(el);
	        }
	        paginationEl.appendChild(fragment);
	    }

	    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	    // 인포윈도우에 장소명을 표시합니다
	    function displayInfowindow(marker, title) {
	        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	        infowindow.setContent(content);
	        infowindow.open(map, marker);
	    }

	     // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	    function removeAllChildNods(el) {   
	        while (el.hasChildNodes()) {
	            el.removeChild (el.lastChild);
	        }
	    }
}

function locationLoadSuccess(pos){
    // 현재 위치 받아오기
    currentPos = new kakao.maps.LatLng(pos.coords.latitude,pos.coords.longitude);
    keywordSearch();

    // 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
    map.panTo(currentPos);

    // 마커 생성
    var marker = new kakao.maps.Marker({
        position: currentPos
    });

    // 기존에 마커가 있다면 제거
    marker.setMap(null);
    marker.setMap(map);
};

function locationLoadError(pos){
    alert('위치 정보를 가져오는데 실패했습니다.');
};

// 위치 가져오기 버튼 클릭시
function getCurrentPosBtn(){
    navigator.geolocation.getCurrentPosition(locationLoadSuccess,locationLoadError);
};

//마우스 드래그로 지도 이동이 완료되었을 때 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'dragend', function() {        
	 
    // 지도 중심좌표를 얻어옵니다 
    currentPos = map.getCenter(); 
    
    keywordSearch();
   
    
});

function getCurrentPosByPickBtn(){
    var userInput = prompt('대략적인 위치를 입력해주세요!(서울시 마포구)');

    // 주소 - 좌표 변환 객체 생성
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(userInput, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords,
                draggable: true
            });

            // 현재 위치 갱신
            currentPos = coords;

            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">' +
                    '검색 위치!</div>'
            });
            infowindow.open(map, marker);
            
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        }
    });
}
</script>

	<%@ include file="includes/footer.jsp" %>		