<%@ include file="/WEB-INF/jsp/includes.jsp" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCLHRdca8dIAKOzZ6s4XUB4GXh7RDWJPac&sensor=true"></script>
<script type="text/javascript">

    var marker = null;
    var map = null;

    $(document).ready(function () {
        $('.button').button();
        
        initializeMap();
        
         $('#from').datepicker({
            dateFormat: 'yy/mm/dd',
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            maxDate: 0,
            changeMonth: true,
            numberOfMonths: 3,
            onClose: function( selectedDate ) {
                $('#to' ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $('#to').datepicker({
            dateFormat: 'yy/mm/dd',
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
            maxDate: 0,
            changeMonth: true,
            numberOfMonths: 3,
            onClose: function( selectedDate ) {
                $('#from').datepicker( "option", "maxDate", selectedDate );
            }
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
    
    function clearFilter(tipo){
        if(tipo=='fecha'){
            $('#from').val($('#today').val());
            $('#to').val($('#today').val());
        }else{
            $('#horainicial').val(0);
            $('#horafinal').val(0);
        }
        sendFilter();
    }

    function sendFilter(){
        var from=$('#from').val();
        var to=$('#to').val();
        var hi=$('#horainicial').val();
        var hf=$('#horafinal').val();
        var tipos='';
        $('.cbtipo').each(function(){
            if($(this).is(':checked')){
                tipos+=$(this).val()+',';
            }
        });
        
        console.log('sendFilter from:'+from+' to:'+to+' hi:'+hi+' hf:'+hf+' tipos:'+tipos);
        if(tipos!=''){
            tipos=tipos.substring(0,tipos.length-1);
        }
        
        $.ajax({
            url:'<spring:url value="/Default/incidentesFiltro"/>',
            data:{tipos:tipos, from:from, to:to, hi:hi, hf:hf},
            dataType:'json',
            cache:false,
            success:function(result){
                alert('result:'+result);
            }
        });
    }

</script>


<div class="menutop">
<ul>
  <li><a class="button" href='<spring:url value="/incidente" htmlEscape="true" />'>Reportar incidente</a></li>
  <li><a class="button" href='<spring:url value="/administrar" htmlEscape="true" />'>Moderador</a></li>
  <li><a class="button" href='<spring:url value="/informes" htmlEscape="true" />'>Informes</a></li>
</ul>
</div>
<div class="principal rounded5">
    <div class="opciones rounded5">
        <div class="fechahora">
            <label for="tipo">Filtrar por tipo</label><br/>
            <c:forEach items="${listaTipos}" var="tipocoordenada">
                <span class="tipoincidente">
                    <input type="checkbox" value="${tipocoordenada.tipo}" checked="checked" class="cbtipo"/>
                    <span class="desc">${tipocoordenada.descripcion}</span>
                </span>
            </c:forEach>
        </div>
        <div class="fechahora">
            <label for="fechaincidente">Filtrar por fecha</label><br/>
            <span class="tipoincidente">
                <span class="labelinterno">Desde:</span>
                <input type="text" id="from" class="rounded3 date" readonly="readonly" value="${today}" />
            </span>
            <span class="tipoincidente">
                <span class="labelinterno">Hasta:</span>
                <input type="text" id="to" class="rounded3 date" readonly="readonly" value="${today}" />
            </span>
            <span class="tipoincidente">
                <a class="clearfilter" href="javascript:void(0)" onclick="clearFilter('fecha')">Quitar filtro por fecha</a>
            </span>
        </div>
        <div class="fechahora">
            <label for="horaincidente">Filtrar por horas</label><br/>
            <span class="tipoincidente">
                <span class="labelinterno">Desde:</span>
                <select id="horainicial" class="rounded3">
                    <c:forEach var="i" begin="0" end="23">
                        <c:choose>
                            <c:when test="${i==0}">
                                <option value="${i}" selected="selected"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </span>
            <span class="tipoincidente">
                <span class="labelinterno">Hasta:</span>
                <select id="horafinal" class="rounded3">
                    <c:forEach var="i" begin="0" end="23">
                        <c:choose>
                            <c:when test="${i==0}">
                                <option value="${i}" selected="selected"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}"><fmt:formatNumber type="number" pattern="00" value="${i}"/></option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </span>
            <span class="tipoincidente">
                <a class="clearfilter" href="javascript:void(0)" onclick="clearFilter('hora')">Quitar filtro por hora</a>
            </span>
        </div>
        <div class="fechahora lineatop">
            <input type="button" class="button" onclick="sendFilter()" value="Filtrar" />
        </div>
    </div>

    <div class="principalmap">
        <div id="mapa" class="rounded5"></div>
    </div>
    <input type="hidden" value="${today}" id="today">
</div>

<div class="clear"></div>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
