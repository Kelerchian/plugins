import PluginBase from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/plugin-base.js';import ExtensionUtil from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/extension-util.js';let autoscrollIntervalId;const SCROLL_SPEED_FACTORS=[240,120,90,60,36,24,12,6];let scrollNodes=[],scrollIndex=0;function stopAutoscroll(){window.clearInterval(autoscrollIntervalId),PluginBase.util.removeContext("Auto Scroll");}function setAutoscroll(indexDelta=0){let prevPos;const zoomFactor=window.outerWidth/window.document.documentElement.clientWidth,scrollFactor=Math.round(1/zoomFactor*10)/10+.1,savedScrollSpeed=PluginBase.getPluginOption("Scroll","autoscroll-index");let scrollSpeedIndex=("number"==typeof savedScrollSpeed?savedScrollSpeed:3)+indexDelta;scrollSpeedIndex>=SCROLL_SPEED_FACTORS.length?scrollSpeedIndex=SCROLL_SPEED_FACTORS.length-1:scrollSpeedIndex<0&&(scrollSpeedIndex=0),PluginBase.setPluginOption("Scroll","autoscroll-index",scrollSpeedIndex),window.clearInterval(autoscrollIntervalId);const scrollEl=getScrollEl();scrollEl&&(autoscrollIntervalId=window.setInterval(()=>{const scrollYPos=scrollEl.scrollY||scrollEl.scrollTop;scrollEl.scrollBy(0,scrollFactor),prevPos&&(scrollYPos-prevPos<=0||scrollYPos-prevPos>1.5*scrollFactor)&&stopAutoscroll(),prevPos=scrollYPos;},SCROLL_SPEED_FACTORS[scrollSpeedIndex]));}function hasScroll(el,direction,barSize){const offset="y"===direction?["scrollTop","height"]:["scrollLeft","width"];let scrollPos=el[offset[0]];if(scrollPos<barSize){const originOffset=el[offset[0]];el[offset[0]]=el.getBoundingClientRect()[offset[1]],scrollPos=el[offset[0]],el[offset[0]]=originOffset;}return scrollPos>=barSize}function scrollableMousedownHandler(e){const n=e.currentTarget,target=e.target;if(!n.contains(target))return;let index=scrollNodes.lastIndexOf(target);if(-1===index){for(var i=scrollNodes.length-1;i>=0;i--)if(scrollNodes[i].contains(target)){index=i;break}-1===index&&console.warn("cannot find scrollable",e.target);}scrollIndex=index;}function getScrollableEls(){console.time("getScrollableEls");let nodes=function listElements(root,whatToShow,filter){const elms=[];let currentNode;const nodeIterator=document.createNodeIterator(root,whatToShow,null);for(;currentNode=nodeIterator.nextNode();)filter(currentNode)&&elms.push(currentNode),currentNode.shadowRoot&&elms.push(...listElements(currentNode.shadowRoot,whatToShow,filter));return elms}(document.body,NodeFilter.SHOW_ELEMENT,(function(n){return hasScroll(n,"y",16)&&n.scrollHeight-n.offsetHeight>60||hasScroll(n,"x",16)&&n.scrollWidth-n.scrollWidth>60}));return nodes.sort((function(a,b){return b.contains(a)?1:a.contains(b)?-1:b.scrollHeight*b.scrollWidth-a.scrollHeight*a.scrollWidth})),(document.scrollingElement.scrollHeight>window.innerHeight||document.scrollingElement.scrollWidth>window.innerWidth)&&nodes.unshift(document.scrollingElement),nodes.forEach((function(n){n.removeEventListener("mousedown",scrollableMousedownHandler),n.addEventListener("mousedown",scrollableMousedownHandler);})),console.timeEnd("getScrollableEls"),nodes}function getScrollEl(){let el=window;const helpBox=document.getElementById(PluginBase.util.getNoCollisionUniqueAttr()+"-helpBox");return helpBox&&helpBox.scrollHeight>helpBox.clientHeight?el=helpBox:"docs.google.com"===document.location.host?el=document.querySelector(".kix-appview-editor"):document.scrollingElement.scrollHeight>window.innerHeight||document.scrollingElement.scrollWidth>window.innerWidth?el=document.scrollingElement:(scrollNodes=getScrollableEls(),el=scrollNodes[scrollIndex]),el}async function scrollAmount({top:top,left:left},relative=!0,el=getScrollEl()){if(el){const scrollObj={top:top,left:left,behavior:"smooth"};relative?el.scrollBy(scrollObj):el.scrollTo(scrollObj);}return stopAutoscroll(),await PluginBase.util.sleep(400)}async function scroll(direction,little=!1){const needsKeyPressEvents=/\.pdf$/.test(document.location.pathname);let factor,key;switch(direction){case"u":case"hu":factor=-.85,key=38;break;case"d":case"hd":factor=.85,key=40;break;case"l":factor=-.7,key=37;break;case"r":factor=.7,key=39;break;case"t":factor=0,key=36;break;case"b":factor=1e4,key=35;}const littleFactor=little?.5:1;if("hd"===direction||"hu"===direction){const helpContents=PluginBase.util.getHUDEl()[0].querySelector("#help .cmds");scrollAmount({top:helpContents.offsetHeight*factor},!0,helpContents);}else if(needsKeyPressEvents){let codes;codes="t"===direction||"b"===direction?[key]:new Array(14*littleFactor).fill(key),chrome.runtime.sendMessage({type:"pressKeys",payload:{codes:codes,nonChar:!0}});}else{if("l"===direction||"r"===direction)scrollAmount({left:window.innerWidth*factor*littleFactor});else{const relative="t"!==direction;if("b"===direction&&0!=document.body.scrollHeight)return scrollAmount({top:document.documentElement.scrollHeight});scrollAmount({top:window.innerHeight*factor*littleFactor},relative);}}}function queryScrollPos(querySelector){if(querySelector){return document.querySelector(querySelector).scrollTop}return window.scrollY}async function testScroll(t,say,client,url,querySelector,test={greater:!0}){await client.url(url),t.is(await client.getUrl(),url),(test.zero||test.lessThan)&&await say("bottom");const scrollStart=await client.execute(queryScrollPos,querySelector);await say();const scrollEnd=await client.execute(queryScrollPos,querySelector);test.greater?t.true(scrollEnd>scrollStart,`scrollStart: ${scrollStart} scrollEnd: ${scrollEnd} for ${url}`):test.lessThan?t.true(scrollEnd<scrollStart,`scrollStart: ${scrollStart} scrollEnd: ${scrollEnd} for ${url}`):test.zero&&t.is(scrollEnd,0,`scrollStart: ${scrollStart} scrollEnd: ${scrollEnd} for ${url}`);}var Scroll={...PluginBase,niceName:"Scroll",languages:{},description:"Commands for scrolling the page.",icon:'<svg xmlns="http://www.w3.org/2000/svg" version="1" viewBox="0 0 128 128"><g class="iconic-move-sm iconic-container iconic-sm" transform="scale(8)">\n    <path stroke="#000" stroke-width="2" stroke-linecap="square" d="M8 3v11" fill="none"></path>\n    <path stroke="#000" stroke-width="2" stroke-linecap="square" d="M13 8h-10" fill="none"></path>\n    <path d="M8 0l-3 3h6z"></path>\n    <path d="M16 8l-3-3v6z"></path>\n    <path d="M0 8l3 3v-6z"></path>\n    <path d="M8 16l3-3h-6z"></path>\n</g></svg>',version:"3.7.0",match:/.*/,authors:"Miko",homophones:{autoscroll:"auto scroll",horoscrope:"auto scroll",app:"up",upwards:"up",upward:"up",dumb:"down",gout:"down",downwards:"down",town:"down",don:"down",downward:"down",boreham:"bottom",volume:"bottom",barton:"bottom",barn:"bottom",born:"bottom",littledown:"little down","put it down":"little down","will down":"little down",middletown:"little down","little rock":"little up","lidl up":"little up","school little rock":"scroll little up","time of the page":"top of the page",scrolltop:"scroll top","scrub top":"scroll top",talk:"top",chop:"top",school:"scroll",screw:"scroll",small:"little",flower:"slower",lower:"slower",pastor:"faster",master:"faster","auto spa":"auto scroll",scallop:"scroll up","school health":"scroll help",prohealth:"scroll help"},contexts:{"Auto Scroll":{commands:["Speed Up","Slow Down","Stop"]}},destroy(){stopAutoscroll();},commands:[{name:"Scroll Down",match:["[/scroll ]down"],activeDocument:!0,pageFn:()=>scroll("d"),test:{google:async(t,say,client)=>{await testScroll(t,say,client,"https://www.google.com/search?q=lipsurf");},gdocs:async(t,say,client)=>{await testScroll(t,say,client,"https://docs.google.com/document/d/1Tdfk2UvIXxwZOoluLh6o1kN1CrKHWbXcmUIsDKRHTEI/edit",".kix-appview-editor");},gmail:async(t,say,client)=>{await testScroll(t,say,client,t.context.localPageDomain+"/gmail-long-message.html","#\\:3");},whatsapp:async(t,say,client)=>{await testScroll(t,say,client,t.context.localPageDomain+"/whatsapp.html","._1_keJ");},quip:async(t,say,client)=>{await testScroll(t,say,client,t.context.localPageDomain+"/quip.html",".parts-screen-body.scrollable");},iframe:async(t,say,client)=>{const getScrollPos=()=>{var _a;return null===(_a=document.querySelector("iframe").contentDocument)||void 0===_a?void 0:_a.querySelector("._1_keJ").scrollTop};await client.url(t.context.localPageDomain+"/scroll-iframe.html"),await(await client.$("iframe")).click();const scrollStart=await client.execute(getScrollPos);await say();const scrollEnd=await client.execute(getScrollPos);t.true(scrollEnd>scrollStart,`scrollStart: ${scrollStart} scrollEnd: ${scrollEnd}`);}}},{name:"Scroll Up",match:["[/scroll ]up"],activeDocument:!0,pageFn:()=>scroll("u")},{name:"Auto Scroll",match:["[auto/automatic] scroll"],description:"Continuously scroll down the page slowly, at a reading pace.",activeDocument:!0,pageFn:()=>{PluginBase.util.addContext("Auto Scroll"),setAutoscroll();}},{name:"Slow Down",match:["slower","slow down"],description:"Slow down the auto scroll",activeDocument:!0,normal:!1,pageFn:()=>{setAutoscroll(-1);}},{name:"Speed Up",match:["faster","speed up"],activeDocument:!0,normal:!1,description:"Speed up the auto scroll",pageFn:()=>{setAutoscroll(1);}},{name:"Stop",match:["stop","pause"],activeDocument:!0,normal:!1,description:"Stop the auto scrolling.",pageFn:()=>{stopAutoscroll();}},{name:"Scroll Bottom",match:["bottom[/ of page/of the page]","scroll [bottom/to bottom/to the bottom/to bottom of page/to the bottom of the page]"],activeDocument:!0,pageFn:()=>scroll("b"),test:async(t,say,client)=>{await testScroll(t,say,client,"http://motherfuckingwebsite.com/");}},{name:"Scroll Top",match:["top[/ of page/ of the page]","scroll [top/to top/to the top/to the top of the page]"],activeDocument:!0,pageFn:()=>scroll("t"),test:async(t,say,client)=>{await testScroll(t,say,client,"http://motherfuckingwebsite.com/",void 0,{zero:!0});}},{name:"Scroll Help Down",match:"scroll help down",pageFn:()=>scroll("hd",!0)},{name:"Scroll Help Up",match:"scroll help up",pageFn:()=>scroll("hu",!0)},{name:"Scroll Down a Little",match:["little [scroll /]down"],activeDocument:!0,pageFn:()=>scroll("d",!0)},{name:"Scroll Up a Little",match:["little [scroll/ ]up"],activeDocument:!0,pageFn:()=>scroll("u",!0)},{name:"Scroll Left",match:"scroll left",activeDocument:!0,pageFn:()=>scroll("l")},{name:"Scroll Right",match:"scroll right",activeDocument:!0,pageFn:()=>scroll("r")}]};Scroll.languages.es={niceName:"Desplazarse",authors:"Miko",commands:{"Scroll Bottom":{name:"Desplazarse Hasta Abajo",match:["desplazarse hasta abajo","parte inferior","final"]},"Scroll Top":{name:"Desplazarse Hasta Arriba",match:["[desplazarse hasta] [/parte ]arriba","cima","parte arriba"]},"Scroll Down":{name:"Desplazarse Hacia Abajo",match:["[/desplazarse hacia ]abajo"]},"Scroll Up":{name:"Desplazarse Hacia Arriba",match:["[/desplazarse hacia ]arriba"]},"Scroll Right":{name:"Desplazarse a la Derecha",match:["desplazarse a la derecha"]},"Scroll Left":{name:"Desplazarse a la Izquierda",match:["desplazarse a la izquierda"]},"Scroll Down a Little":{name:"Un Poco Abajo",match:["un poco abajo"]},"Scroll Up a Little":{name:"Un Poco Arriba",match:["un poco arriba"]},"Auto Scroll":{name:"Desplazamiento Automático",match:"desplazamiento automático"},Slower:{name:"Más Lento",match:"lento"},Faster:{name:"Más Rápido",match:"rápido"},"Scroll Help Down":{name:"Desplazar la Ayuda Abajo",match:"ayuda abajo"},"Scroll Help Up":{name:"Desplazar la Ayuda Arriba",match:"ayuda arriba"}}},Scroll.languages.fr={niceName:"Défilement",authors:"Byron Kearns, Miko",homophones:{"des fils vers le bas":"défile vers le bas","des fils vers le haut":"défile vers le haut",ralenti:"ralentis","défilé en haut":"défiler en haut","des fils en haut":"défile en haut","des fils un peu vers le bas":"défile un peu en bas","des fils un peu vers le haut":"défile un peu vers le haut"},commands:{"Scroll Down":{name:"Défilement vers le Bas",match:["[/faire défiler /défiler ]vers le bas"]},"Scroll Up":{name:"Défilement vers le Haut",match:["[/faire défiler /défiler ]vers le haut"]},"Auto Scroll":{name:"Défilement Automatique",match:["défilement [automatique/auto]"]},"Slow Down":{name:"Ralentir",match:["plus lentement","ralentir"]},"Speed Up":{name:"Accélérer",match:["plus vite","accélérer"]},Stop:{name:"Arrêter",match:["arrêter","pause"]},"Scroll Bottom":{name:"Défilement en Bas",match:["en bas","bas de page","[faire défiler/défiler] en bas","aller en bas de la page"]},"Scroll Top":{name:"Défilement en Haut",match:["en haut","haut de page","[faire défiler/défiler] en haut","aller en haut de la page"]},"Scroll Down a Little":{name:"Défilement Léger vers le Bas",match:["[/faire défiler /défiler ]un peu vers le bas"]},"Scroll Up a Little":{name:"Défilement Léger vers le Haut",match:["[/faire défiler /défiler ]un peu vers le haut"]},"Scroll Left":{name:"Défilement à Gauche",match:["[faire /]défiler à gauche","[/faire ]défiler vers la gauche"]},"Scroll Right":{name:"Défilement à Droite",match:["[faire /]défiler à droite","[/faire ]défiler vers la droite"]},"Scroll Help Down":{name:"Faire Défiler l’Aide vers le Bas",match:["[faire /]défiler l'aide vers le bas"]},"Scroll Help Up":{name:"Faire Défiler l’Aide vers le Haut",match:["[faire /]défiler l'aide vers le haut"]}}},Scroll.languages.ja={niceName:"スクロール",description:"ページのスクロールを管理できます。",homophones:{"しーた":"した","ちーたー":"した"},authors:"Miko, Hiroki Yamazaki",commands:{"Scroll Bottom":{name:"ページの一番下に移動",match:["いちばんした"]},"Scroll Top":{name:"ページの一番上に移動",match:["いちばんうえ"]},"Scroll Down":{name:"下にスクロール",match:["した[/にすくろーる/へすくろーる]","だうん"]},"Scroll Up":{name:"上にスクロール",match:["うえ[/にすくろーる/へすくろーる]","あっぷ"]},"Scroll Right":{name:"右にスクロール",match:["みぎ[/にすくろーる/へすくろーる]"]},"Scroll Left":{name:"左にスクロール",match:["ひだり[/にすくろーる/へすくろーる]"]},"Scroll Up a Little":{name:"少し上にスクロール",match:["すこしうえ[/にすくろーる/へすくろーる]"]},"Scroll Down a Little":{name:"少し下にスクロール",match:["すこしした[/にすくろーる/へすくろーる]"]},"Auto Scroll":{name:"自動スクロール",match:"じどうすくろーる"},Faster:{name:"もっと早くスクロール",match:"はやく"},Slower:{name:"もっとゆっくりスクロール",match:"ゆっくり"},Stop:{name:"スクロールを止める",match:["すとっぷ","ていし","とめる"]},"Scroll Help Down":{name:"ヘルプ下",match:"へるぷした"},"Scroll Help Up":{name:"ヘルプ上",match:"へるぷうえ"}}},Scroll.languages.ru={niceName:"Браузер",description:"Контроль действий в браузере, как-то: создание новой вкладки, навигация по странице (назад, вперед, вниз), вызов справки и т.д.",homophones:{"тунис":"вниз","обнинск":"вниз","знаешь":"вниз","вниис":"вниз",beer:"вверх","вир":"вверх","вера":"вверх"},commands:{"Scroll Bottom":{name:"Прокрутить в конец страницы",match:["в конец","конец страницы"]},"Scroll Down a Little":{name:"Прокрутить немного вниз",match:["[немного/чутьчуть] вниз"]},"Scroll Down":{name:"Прокрутить вниз",match:["вниз"]},"Scroll Top":{name:"Вернуться на верх страницы",match:["на верх страницы"]},"Scroll Up a Little":{name:"Прокрутить немного вверх",match:["[немного/чутьчуть] вверх"]},"Scroll Up":{name:"Прокрутить вверх",match:["вверх"]},"Scroll Left":{name:"Прокрутить влево",match:["влево"]},"Scroll Right":{name:"Прокрутить вправо",match:["вправо"]},"Auto Scroll":{name:"Автопрокрутка",match:"автопрокрутка"}}};

export default Scroll;LS-SPLITallPlugins.Scroll = (() => { let autoscrollIntervalId;const SCROLL_SPEED_FACTORS=[240,120,90,60,36,24,12,6];let scrollNodes=[],scrollIndex=0;function stopAutoscroll(){window.clearInterval(autoscrollIntervalId),PluginBase.util.removeContext("Auto Scroll");}function setAutoscroll(indexDelta=0){let prevPos;const zoomFactor=window.outerWidth/window.document.documentElement.clientWidth,scrollFactor=Math.round(1/zoomFactor*10)/10+.1,savedScrollSpeed=PluginBase.getPluginOption("Scroll","autoscroll-index");let scrollSpeedIndex=("number"==typeof savedScrollSpeed?savedScrollSpeed:3)+indexDelta;scrollSpeedIndex>=SCROLL_SPEED_FACTORS.length?scrollSpeedIndex=SCROLL_SPEED_FACTORS.length-1:scrollSpeedIndex<0&&(scrollSpeedIndex=0),PluginBase.setPluginOption("Scroll","autoscroll-index",scrollSpeedIndex),window.clearInterval(autoscrollIntervalId);const scrollEl=getScrollEl();scrollEl&&(autoscrollIntervalId=window.setInterval(()=>{const scrollYPos=scrollEl.scrollY||scrollEl.scrollTop;scrollEl.scrollBy(0,scrollFactor),prevPos&&(scrollYPos-prevPos<=0||scrollYPos-prevPos>1.5*scrollFactor)&&stopAutoscroll(),prevPos=scrollYPos;},SCROLL_SPEED_FACTORS[scrollSpeedIndex]));}function hasScroll(el,direction,barSize){const offset="y"===direction?["scrollTop","height"]:["scrollLeft","width"];let scrollPos=el[offset[0]];if(scrollPos<barSize){const originOffset=el[offset[0]];el[offset[0]]=el.getBoundingClientRect()[offset[1]],scrollPos=el[offset[0]],el[offset[0]]=originOffset;}return scrollPos>=barSize}function scrollableMousedownHandler(e){const n=e.currentTarget,target=e.target;if(!n.contains(target))return;let index=scrollNodes.lastIndexOf(target);if(-1===index){for(var i=scrollNodes.length-1;i>=0;i--)if(scrollNodes[i].contains(target)){index=i;break}-1===index&&console.warn("cannot find scrollable",e.target);}scrollIndex=index;}function getScrollableEls(){console.time("getScrollableEls");let nodes=function listElements(root,whatToShow,filter){const elms=[];let currentNode;const nodeIterator=document.createNodeIterator(root,whatToShow,null);for(;currentNode=nodeIterator.nextNode();)filter(currentNode)&&elms.push(currentNode),currentNode.shadowRoot&&elms.push(...listElements(currentNode.shadowRoot,whatToShow,filter));return elms}(document.body,NodeFilter.SHOW_ELEMENT,(function(n){return hasScroll(n,"y",16)&&n.scrollHeight-n.offsetHeight>60||hasScroll(n,"x",16)&&n.scrollWidth-n.scrollWidth>60}));return nodes.sort((function(a,b){return b.contains(a)?1:a.contains(b)?-1:b.scrollHeight*b.scrollWidth-a.scrollHeight*a.scrollWidth})),(document.scrollingElement.scrollHeight>window.innerHeight||document.scrollingElement.scrollWidth>window.innerWidth)&&nodes.unshift(document.scrollingElement),nodes.forEach((function(n){n.removeEventListener("mousedown",scrollableMousedownHandler),n.addEventListener("mousedown",scrollableMousedownHandler);})),console.timeEnd("getScrollableEls"),nodes}function getScrollEl(){let el=window;const helpBox=document.getElementById(PluginBase.util.getNoCollisionUniqueAttr()+"-helpBox");return helpBox&&helpBox.scrollHeight>helpBox.clientHeight?el=helpBox:"docs.google.com"===document.location.host?el=document.querySelector(".kix-appview-editor"):document.scrollingElement.scrollHeight>window.innerHeight||document.scrollingElement.scrollWidth>window.innerWidth?el=document.scrollingElement:(scrollNodes=getScrollableEls(),el=scrollNodes[scrollIndex]),el}async function scrollAmount({top:top,left:left},relative=!0,el=getScrollEl()){if(el){const scrollObj={top:top,left:left,behavior:"smooth"};relative?el.scrollBy(scrollObj):el.scrollTo(scrollObj);}return stopAutoscroll(),await PluginBase.util.sleep(400)}async function scroll(direction,little=!1){const needsKeyPressEvents=/\.pdf$/.test(document.location.pathname);let factor,key;switch(direction){case"u":case"hu":factor=-.85,key=38;break;case"d":case"hd":factor=.85,key=40;break;case"l":factor=-.7,key=37;break;case"r":factor=.7,key=39;break;case"t":factor=0,key=36;break;case"b":factor=1e4,key=35;}const littleFactor=little?.5:1;if("hd"===direction||"hu"===direction){const helpContents=PluginBase.util.getHUDEl()[0].querySelector("#help .cmds");scrollAmount({top:helpContents.offsetHeight*factor},!0,helpContents);}else if(needsKeyPressEvents){let codes;codes="t"===direction||"b"===direction?[key]:new Array(14*littleFactor).fill(key),chrome.runtime.sendMessage({type:"pressKeys",payload:{codes:codes,nonChar:!0}});}else{if("l"===direction||"r"===direction)scrollAmount({left:window.innerWidth*factor*littleFactor});else{const relative="t"!==direction;if("b"===direction&&0!=document.body.scrollHeight)return scrollAmount({top:document.documentElement.scrollHeight});scrollAmount({top:window.innerHeight*factor*littleFactor},relative);}}}var Scroll={...PluginBase,icon:'<svg xmlns="http://www.w3.org/2000/svg" version="1" viewBox="0 0 128 128"><g class="iconic-move-sm iconic-container iconic-sm" transform="scale(8)">\n    <path stroke="#000" stroke-width="2" stroke-linecap="square" d="M8 3v11" fill="none"></path>\n    <path stroke="#000" stroke-width="2" stroke-linecap="square" d="M13 8h-10" fill="none"></path>\n    <path d="M8 0l-3 3h6z"></path>\n    <path d="M16 8l-3-3v6z"></path>\n    <path d="M0 8l3 3v-6z"></path>\n    <path d="M8 16l3-3h-6z"></path>\n</g></svg>',destroy(){stopAutoscroll();},commands:{"Scroll Down":{pageFn:()=>scroll("d")},"Scroll Up":{pageFn:()=>scroll("u")},"Auto Scroll":{pageFn:()=>{PluginBase.util.addContext("Auto Scroll"),setAutoscroll();}},"Slow Down":{normal:!1,pageFn:()=>{setAutoscroll(-1);}},"Speed Up":{normal:!1,pageFn:()=>{setAutoscroll(1);}},Stop:{normal:!1,pageFn:()=>{stopAutoscroll();}},"Scroll Bottom":{pageFn:()=>scroll("b")},"Scroll Top":{pageFn:()=>scroll("t")},"Scroll Help Down":{pageFn:()=>scroll("hd",!0)},"Scroll Help Up":{pageFn:()=>scroll("hu",!0)},"Scroll Down a Little":{pageFn:()=>scroll("d",!0)},"Scroll Up a Little":{pageFn:()=>scroll("u",!0)},"Scroll Left":{pageFn:()=>scroll("l")},"Scroll Right":{pageFn:()=>scroll("r")}}};

return Scroll;
 })()LS-SPLIT