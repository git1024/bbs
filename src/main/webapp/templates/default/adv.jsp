<%@ page language="java" import="cn.jsprun.utils.Common;" pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose><c:when test="${fid!=null}"><c:set var="target" value="forum_${fid}" scope="page"/></c:when><c:otherwise><c:set var="target" value="0" scope="page"/></c:otherwise></c:choose>
<c:if test="${CURSCRIPT=='forumdisplay.jsp'}"><script type="text/javascript">
var normalthreads = new Array();
var floatthreads = new Array();
var tbodys = $('forum_${fid}');
if(tbodys!=null){
	tbodys=tbodys.getElementsByTagName('tbody');
	var randtbody = null;
	for(var i in tbodys) {
		if(tbodys[i].id) {
			if(tbodys[i].id.substr(0, 12) == 'normalthread') {
				normalthreads.push(tbodys[i]);
			} else if(tbodys[i].id.substr(0, 11) == 'floatthread') {
				floatthreads.push(tbodys[i]);
			}
		}
	}
	if(normalthreads.length) {
		for(var i = 0; i < floatthreads.length; i++) {
			var randtbody = normalthreads[Math.floor(Math.random()*normalthreads.length)];
			randtbody.insertBefore(floatthreads[i].getElementsByTagName('tr')[0], randtbody.getElementsByTagName('tr')[0]);
			floatthreads[i].parentNode.removeChild(floatthreads[i]);
		}
	}
}
</script></c:if>
<div style="display: none" id="ad_none"><div id="ad_headerbanner_none">${advlist.headerbanner[target]!=null?advitems[advlist.headerbanner[target]]:advitems[advlist.headerbanner['all']]}</div>
<c:if test="${advlist.text[target]!=null}"><div class="ad_text" id="ad_text_none"><table summary="Text Ad" cellpadding="0" cellspacing="1">${advlist.text[target]}</table></div></c:if>
<c:if test="${CURSCRIPT=='index.jsp'&&advlist.intercat!=null}"><c:forEach items="${catlists}" var="cat"><c:choose><c:when test="${advlist.intercat[(cat.fid)]!=null&&advitems[advlist.intercat['0']]!=null}"><c:choose><c:when test="<%=Common.rand(1)==1%>"><div class="ad_column" id="ad_intercat_${cat.fid}_none">${advitems[advlist.intercat[(cat.fid)]]}</div></c:when><c:otherwise><div class="ad_column" id="ad_intercat_${cat.fid}_none">${advitems[advlist.intercat['0']]}</div></c:otherwise></c:choose></c:when><c:when test="${advlist.intercat[(cat.fid)]!=null}"><div class="ad_column" id="ad_intercat_${cat.fid}_none">${advitems[advlist.intercat[(cat.fid)]]}</div></c:when><c:when test="${advitems[advlist.intercat['0']]!=null}"><div class="ad_column" id="ad_intercat_${cat.fid}_none">${advitems[advlist.intercat['0']]}</div></c:when></c:choose></c:forEach></c:if>
<c:if test="${CURSCRIPT=='viewthread.jsp'}">
	<c:if test="${!(special>0)}"><c:forEach items="${postlist}" var="post" varStatus="index"><div class="ad_textlink1" id="ad_thread1_${index.index}_none">${advthreads.thread1[index.index]}</div><div class="ad_textlink2" id="ad_thread2_${index.index}_none">${advthreads.thread2[index.index]}</div><div class="ad_pip" id="ad_thread3_${index.index}_none">${advthreads.thread3[index.index]}</div></c:forEach></c:if>
	<div class="ad_column" id="ad_interthread_none">${thread.replies>0?(advlist.interthread[target]!=null?advitems[advlist.interthread[target]]:advitems[advlist.interthread['all']]):""}</div>
</c:if>
<div class="ad_footerbanner" id="ad_footerbanner1_none">${advlist.footerbanner1[target]!=null?advitems[advlist.footerbanner1[target]]:advitems[advlist.footerbanner1['all']]}</div>
<div class="ad_footerbanner" id="ad_footerbanner2_none">${advlist.footerbanner2[target]!=null?advitems[advlist.footerbanner2[target]]:advitems[advlist.footerbanner2['all']]}</div>
<div class="ad_footerbanner" id="ad_footerbanner3_none">${advlist.footerbanner3[target]!=null?advitems[advlist.footerbanner3[target]]:advitems[advlist.footerbanner3['all']]}</div></div>
<script type="text/javascript">
var insenz_status = '${insenz.hardadstatus!=null?1:0}';
var insenz_availableadvs = {'headerbanner' : '1', 'thread3_0' : '2', 'thread2_0' : '3', 'thread1_0' : '4', 'interthread' : '5', 'footerbanner1' : '6', 'footerbanner2' : '7', 'footerbanner3' : '8'};
var insenz_adkeys = [${insenz.hardadstatus}];
var ad_divs = $('ad_none').getElementsByTagName('div');
var insenz_cookie = document.cookie.indexOf('insenz_cookie') == -1 ? null : getcookie('insenz_cookie');
var ad_obj = null;
if(!insenz_status || insenz_cookie) {
	for(var i = 0; i < ad_divs.length; i++) {
		if(ad_divs[i].id.substr(0, 3) == 'ad_' && (ad_obj = $(ad_divs[i].id.substr(0, ad_divs[i].id.length - 5))) && ad_divs[i].innerHTML) {
			if(insenz_cookie) {
				re = new RegExp(insenz_availableadvs[ad_divs[i].id.substr(3, ad_divs[i].id.length - 8)] + "\:(0" + "|" + gid + "|" + fid + ")", "ig");
				if(re.exec(insenz_cookie) != null) continue;
			}
			ad_obj.innerHTML = ad_divs[i].innerHTML;
			ad_obj.className = ad_divs[i].className;
		}
	}
}
</script>
<script type="text/javascript">
if(insenz_status) {
	if(typeof insenz_usedadkeys != 'undefined' && typeof insenz_advs != 'undefined' && insenz_usedadkeys.length && insenz_advs.length) {
		insenz_cookie = '';
		for(var j in insenz_advs) {
			for(var k in insenz_advs[j]) {
				insenz_cookie += j + ':' + k + 'D';
			}
		}
		setcookie('insenz_cookie', insenz_cookie, 86400);
	} else {
		insenz_cookie = 1;
		setcookie('insenz_cookie', '', -86400);
		var insenz_usedadkeys = new Array();
	}
	if(insenz_cookie) {
		for(var i = 0; i < ad_divs.length; i++) {
			if(ad_divs[i].id.substr(0, 3) == 'ad_' && (ad_obj = $(ad_divs[i].id.substr(0, ad_divs[i].id.length - 5))) && ad_divs[i].innerHTML && !in_array(insenz_availableadvs[ad_divs[i].id.substr(3, ad_divs[i].id.length - 8)], insenz_usedadkeys)) {
				ad_obj.innerHTML = ad_divs[i].innerHTML;
				ad_obj.className = ad_divs[i].className;
			}
		}
	}
}
$('ad_none').parentNode.removeChild($('ad_none'));
</script>
<c:if test="${advlist.float!=null||advlist.couplebanner!=null}">
<div align="left"  style="clear: both;">
	<script type="text/javascript" src="include/javascript/floatadv.js"></script>
	<script type="text/javascript">
	if(${advlist.float[target]!=null}){
		theFloaters.addItem('floatAdv1',6,'document.documentElement.clientHeight-200','<div style="position: absolute; left: 6px; top: 6px;">${advitems[advlist.float[target]]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
	}
	else if(${advlist.float['all']!=null}){
		theFloaters.addItem('floatAdv1',6,'document.documentElement.clientHeight-200','<div style="position: absolute; left: 6px; top: 6px;">${advitems[advlist.float['all']]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
	}
	if(${advlist.couplebanner[target]!=null}){
		theFloaters.addItem('coupleBannerL',6,0,'<div style="position: absolute; left: 6px; top: 6px;">${advitems[advlist.couplebanner[target]]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
		theFloaters.addItem('coupleBannerR','document.body.clientWidth-6',0,'<div style="position: absolute; right: 6px; top: 6px;">${advitems[advlist.couplebanner[target]]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
	}
	else if(${advlist.couplebanner['all']!=null}){
		theFloaters.addItem('coupleBannerL',6,0,'<div style="position: absolute; left: 6px; top: 6px;">${advitems[advlist.couplebanner['all']]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
		theFloaters.addItem('coupleBannerR','document.body.clientWidth-6',0,'<div style="position: absolute; right: 6px; top: 6px;">${advitems[advlist.couplebanner['all']]} <br /><img src=\"images/common/advclose_${sessionScope['org.apache.struts.action.LOCALE']}.gif\" onMouseOver=\"this.style.cursor=\'pointer\'\" onClick=\"closeBanner();\"></div>');
	}
	theFloaters.play();
	</script>
</div>
</c:if>