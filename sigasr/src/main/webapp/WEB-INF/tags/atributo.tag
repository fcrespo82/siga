<%@ tag body-content="scriptless" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>

<%@ attribute name="solicitacao" required="true" type="br.gov.jfrj.siga.sr.model.SrSolicitacao"%>

<c:set var="atributoSolicitacaoMap" value="${solicitacao.atributoSolicitacaoMap}"/>
<c:forEach items="${solicitacao.atributoAssociados}" var="atributo" varStatus="loop">
	<div class="gt-form-row gt-width-66">
		<label>
			${atributo.nomeAtributo} 
			<c:if test="${atributo.descrAtributo != null && atributo.descrAtributo != ''}">
				(${atributo.descrAtributo})
			</c:if>
		</label>
		<c:if test="${atributo.tipoAtributo != null}">
			<input type="hidden" name="solicitacao.atributoSolicitacaoMap[${loop.index}].idAtributo" value="${atributo.idAtributo}" class="${atributo.idAtributo}"/>
			<c:choose>
				<c:when test="${atributo.tipoAtributo.name() == 'TEXTO'}">
					<input type="text" name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" value="${atributoSolicitacaoMap[atributo.idAtributo]}" class="${atributo.idAtributo}" size="70" maxlength="255" />
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'TEXT_AREA'}">
					<textarea cols="85" rows="10" name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" class="${atributo.idAtributo}" maxlength="255">${atributoSolicitacaoMap[atributo.idAtributo]}</textarea>
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'DATA'}">
					<siga:dataCalendar nome="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" id="calendarioAtributo${atributo.idAtributo}"
						value="${atributoSolicitacaoMap[atributo.idAtributo]}" cssClass="${atributo.idAtributo}"/>
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'NUM_INTEIRO'}">
					<input type="text" class="${atributo.idAtributo}"
						onkeypress="javascript: var tecla=(window.event)?event.keyCode:e.which;if((tecla>47 && tecla<58)) return true;  else{  if (tecla==8 || tecla==0) return true;  else  return false;  }"
						name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" value="${atributoSolicitacaoMap[atributo.idAtributo]}" maxlength="9"/>
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'NUM_DECIMAL'}">
					<input type="text" name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" value="${atributoSolicitacaoMap[atributo.idAtributo]}" 
						id="numDecimal" pattern="^\d*(\,\d{2}$)?" title="Somente número e com duas casas decimais EX: 222,22" class="${atributo.idAtributo}" maxlength="9"/>
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'HORA'}">
					<input type="text" name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" value="${atributoSolicitacaoMap[atributo.idAtributo]}" id="horarioAtributo${atributo.idAtributo}" class="${atributo.idAtributo}" />
					<span style="color: red; display: none;" id="erroHoraAtributo${atributo.idAtributo}">Hor&aacute;rio inv&aacute;lido</span>
				</c:when>
				<c:when test="${atributo.tipoAtributo.name() == 'VL_PRE_DEFINIDO'}" >
					<select name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo" value="${atributoSolicitacaoMap[atributo.idAtributo]}" class="${atributo.idAtributo}" >
						<c:forEach items="${atributo.preDefinidoSet}" var="valorAtributoSolicitacao">
							<option value="${valorAtributoSolicitacao}" <c:if test="${atributoSolicitacaoMap[atributo.idAtributo] == valorAtributoSolicitacao}">selected</c:if> >
								${valorAtributoSolicitacao}
							</option>
						</c:forEach>
					</select>
				</c:when>
			</c:choose>
			<siga:error name="solicitacao.atributoSolicitacaoMap[${loop.index}].valorAtributo"/>
		</c:if>
	</div>
</c:forEach>
<script src="/sigasr/javascripts/jquery.maskedinput.min.js"></script>
<script>
	$(function() {
		$("#horarioAtributo${atributo.idAtributo}").mask("99:99");
		$("#horarioAtributo${atributo.idAtributo}").blur(function() {
			var hora = this.value;
			var array = hora.split(':');
			if (array[0] > 23 || array[1] > 59) {
				$('#erroHoraAtributo${atributo.idAtributo}').show(); 
				return;
			}
			$('#erroHoraAtributo${atributo.idAtributo}').hide();    
		});
	});
</script>