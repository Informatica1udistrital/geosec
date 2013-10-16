<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCLHRdca8dIAKOzZ6s4XUB4GXh7RDWJPac&sensor=true"></script>
<script type="text/javascript">

    var marker = null;
    var map = null;

    $(document).ready(function () {
        initializeMap();
        
        $("#fechaincidente").datepicker({
            dateFormat: 'yy/mm/dd',
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            maxDate: 0
        });
    });
    
    function initializeMap() {
        var mapOptions = {
            center: new google.maps.LatLng(4.6431503595568, -74.092328125),
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.HYBRID,
            mapTypeControl: true,
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
            }
        };
        map = new google.maps.Map(document.getElementById("mapa"), mapOptions);
    }

    function setFirstMarker(latLng) {
        if (marker == null) {
            marker = new google.maps.Marker({
                position: latLng,
                title: '',
                map: map,
                draggable: true
            });
            google.maps.event.addListener(marker, 'dragend', function () {
                console.log('mostrar descripcion');
            });
        } else {
            marker.setPosition(latLng);
        }
    }

</script>


<div class="menutop">
<ul>
  <li><a class="rounded5" href='<spring:url value="/incidente" htmlEscape="true" />'>Reportar incidente</a></li>
  <li><a class="rounded5" href='<spring:url value="/administrar" htmlEscape="true" />'>Moderador</a></li>
</ul>
</div>
<div class="principal">
    <div class="opciones">
        <p>
            <label for="tipo">Filtrar por tipo</label><br/>
            <c:forEach items="${listaTipos}" var="tipocoordenada">
                <span class="tipoincidente">
                    <input type="checkbox" value="${tipocoordenada.tipo}" checked="checked"/>
                    <span class="desc">${tipocoordenada.descripcion}</span>
                </span>
            </c:forEach>
        </p>
        <div class="fechahora">
            <label for="fechaincidente">Filtrar por fecha</label><br/>
            <input type="text" id="fechaincidente" class="rounded3 date" readonly="readonly" value="${today}" />
            <select name="hora" id="hora" class="rounded3">
                <c:forEach var="i" begin="0" end="23">
                    <c:choose>
                        <c:when test="${i==hora}">
                            <option value="${i}" selected="selected"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                        </c:when>
                        <c:otherwise>
                            <option value="${i}"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <select name="minuto" id="minuto" class="rounded3">
                <c:forEach var="i" begin="0" end="59">
                    <c:choose>
                        <c:when test="${i==minuto}">
                            <option value="${i}" selected="selected"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                        </c:when>
                        <c:otherwise>
                            <option value="${i}"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
        <p>
            <input type="button" onclick="sendFilter()" value="Filtrar" />
        </p>
    </div>

    <div class="principalmap">
        <div id="mapa" class="rounded5"></div>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/footer.jsp" %>
