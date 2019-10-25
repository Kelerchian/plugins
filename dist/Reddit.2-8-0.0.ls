import PluginBase from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/plugin-base.js';import ExtensionUtil from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/extension-util.js';const thingAttr=`${PluginBase.util.getNoCollisionUniqueAttr()}-thing`,COMMENTS_REGX=/reddit.com\/r\/[^\/]*\/comments\//;function thingAtIndex(i){return `#siteTable>div.thing[${thingAttr}="${i}"]`}function clickIfExists(selector){const el=document.querySelector(selector);el&&el.click();}var Reddit={...PluginBase,niceName:"Reddit",languages:{},description:"Commands for Reddit.com",version:"2.8.0",match:/^https?:\/\/.*\.reddit.com/,authors:"Miko",init:async()=>{/^https?:\/\/www.reddit/.test(document.location.href)&&(document.location.href=document.location.href.replace(/^https?:\/\/.*\.reddit.com/,"http://old.reddit.com")),await PluginBase.util.ready();let index=0;for(let el of document.querySelectorAll("#siteTable>div.thing")){index++,el.setAttribute(thingAttr,""+index);const rank=el.querySelector(".rank");rank.setAttribute("style","\n            display: block !important;\n            margin-right: 10px;\n            opacity: 1 !important';\n        "),rank.innerText=""+index;}},homophones:{navigate:"go",contract:"collapse",claps:"collapse",expense:"expand",explain:"expand",expanding:"expand","expand noun":"expand 9","it's been":"expand",expanse:"expand",expanded:"expand",stand:"expand",xpand:"expand",xmen:"expand",spend:"expand",span:"expand",spell:"expand",spent:"expand","reddit dot com":"reddit","read it":"reddit",shrink:"collapse",advert:"upvote"},commands:[{name:"View Comments",description:"View the comments of a reddit post.",match:"comments #",pageFn:async(transcript,i)=>{clickIfExists(thingAtIndex(i)+" a.comments");}},{name:"Visit Post",description:"Equivalent of clicking a reddit post.",match:["visit #","visit"],pageFn:async(transcript,i)=>{COMMENTS_REGX.test(window.location.href)?clickIfExists("#siteTable p.title a.title"):clickIfExists(thingAtIndex(i)+" a.title");}},{name:"Expand",description:"Expand a preview of a post, or a comment by it's position (rank).",match:["expand #","# expand","expand"],pageFn:async(transcript,i)=>{if(void 0!==i){let el=document.querySelector(`${thingAtIndex(i)} .expando-button.collapsed`);el.click(),PluginBase.util.scrollToAnimated(el,-25);}else{const mainItem=document.querySelector("#siteTable .thing .expando-button.collapsed"),commentItems=Array.from(document.querySelectorAll(".commentarea > div > .thing.collapsed"));if(mainItem&&PluginBase.util.isInViewAndTakesSpace(mainItem))mainItem.click();else{let el;for(el of commentItems.reverse())if(PluginBase.util.isInViewAndTakesSpace(el))return void el.querySelector(".comment.collapsed a.expand").click()}}}},{name:"Collapse",description:"Collapse an expanded preview (or comment if viewing comments). Defaults to topmost in the view port.",match:["collapse #","close","collapse"],pageFn:async(transcript,i)=>{let index=null===i||isNaN(Number(i))?null:Number(i);if(null!==index){document.querySelector(thingAtIndex(index)+" .expando-button:not(.collapsed)").click();}else for(let el of document.querySelectorAll("#siteTable .thing .expando-button.expanded, .commentarea>div>div.thing:not(.collapsed)>div>p>a.expand"))if(PluginBase.util.isInViewAndTakesSpace(el)){el.click();break}},test:async function(context){var tierTwoComment,commentUnderTest;await context.loadPage("https://old.reddit.com/r/IAmA/comments/z1c9z/i_am_barack_obama_president_of_the_united_states/"),await context.driver.wait(context.until.elementIsVisible(context.driver.findElement(context.By.css(".commentarea"))),1e3),await context.driver.executeScript("document.queryElement('.commentarea').scrollIntoView();"),commentUnderTest=(await context.driver.findElements(context.By.xpath("//div[contains(@class, 'noncollapsed')][contains(@class, 'comment')][@data-author='Biinaryy']")))[0],tierTwoComment=(await context.driver.findElements(context.By.xpath("//p[contains(text(), 'HE KNOWS')]")))[0],context.assert.true(await tierTwoComment.isDisplayed()),await context.say(),await context.driver.wait(async()=>~(await commentUnderTest.getAttribute("class")).indexOf(" collapsed")&&!await tierTwoComment.isDisplayed(),1e3);}},{name:"Go to Subreddit",match:{fn:input=>{let match=input.match(/\b(?:go to |show )?(?:are|our|r) (.*)/);if(match){const endPos=match.index+match[0].length;return [match.index,endPos,[match[1].replace(/\s/g,"")]]}},description:"go to/show r [subreddit name] (do not say slash)"},delay:1200,nice:(transcript,matchOutput)=>`go to r/${matchOutput}`,pageFn:async(transcript,subredditName)=>{window.location.href=`https://old.reddit.com/r/${subredditName}`;}},{name:"Go to Reddit",global:!0,match:["reddit","go to reddit"],minConfidence:.5,pageFn:async()=>{document.location.href="https://old.reddit.com";}},{name:"Clear Vote",description:"Unsets the last vote so it's neither up or down.",match:["clear vote #","reset vote #","clear vote","reset vote"],pageFn:async(transcript,i)=>{let index=null===i||isNaN(Number(i))?1:Number(i);clickIfExists(`${thingAtIndex(index)} .arrow.downmod,${thingAtIndex(index)} .arrow.upmod`);}},{name:"Downvote",match:["downvote #","downvote"],description:"Downvote the current post or a post # (doesn't work for comments yet)",pageFn:async(transcript,i)=>{clickIfExists(`${thingAtIndex(null===i||isNaN(Number(i))?1:Number(i))} .arrow.down:not(.downmod)`);}},{name:"Upvote",match:["upvote #","upvote"],description:"Upvote the current post or a post # (doesn't work for comments yet)",pageFn:async(transcript,i)=>{clickIfExists(`${thingAtIndex(null===i||isNaN(Number(i))?1:Number(i))} .arrow.up:not(.upmod)`);}},{name:"Expand All Comments",description:"Expands all the comments.",match:["expand all","expand all comments"],pageFn:async()=>{for(let el of document.querySelectorAll(".thing.comment.collapsed a.expand"))el.click();},test:async function(context){let previousCollapsed;await context.loadPage("https://old.reddit.com/r/OldSchoolCool/comments/2uak5a/arnold_schwarzenegger_flexing_for_two_old_ladies/co6nw85/"),context.driver.wait(context.until.elementIsVisible(context.driver.findElement(context.By.css(".thing.comment.collapsed"))),2e3),previousCollapsed=(await context.driver.findElements(context.By.css(".thing.comment.collapsed"))).length,await context.say(),await context.driver.wait(async()=>(await context.driver.findElements(context.By.css(".thing.comment.collapsed"))).length<previousCollapsed-5,1e3);}}]};Reddit.languages.ja={niceName:"レディット",description:"Redditで操作します",authors:"Miko",commands:{"View Comments":{name:"コメントを診ます",match:["こめんと#"]}}},Reddit.languages.ru={niceName:"Реддит",description:"Команды для сайта Reddit.com",authors:"Hanna",homophones:{reddit:"реддит","голоса":"голос за"},commands:{"View Comments":{name:"Открыть комментарии",description:"Открывает комментарии к посту названного номера.",match:["комментарии к #","комменты к #"]},"Visit Post":{name:"Открыть пост",description:"Кликает пост названного номера.",match:["открыть пост #","открыть пост"]},Expand:{name:"Развернуть",description:"Развернуть превью поста или комментария названного номера.",match:["развернуть","развернуть #","# развернуть"]},Collapse:{name:"Свернуть",description:"Свернуть развернутый пост или комментарий. Если не назван номер, автоматически сворачивает самый верхний пост/ комментарий в пределах экрана.",match:["свернуть","свернуть #","закрыть"]},"Go to Reddit":{name:"Открыть реддит",description:"Переходит на сайт reddit.com",match:["реддит"]},"Clear Vote":{name:"Убрать голос",description:"Убирает последний голос за или против последнего поста или поста названного номера",match:["убрать голос #","убрать голос"]},Downvote:{name:"Голос против",description:"Голосует против данного поста или поста названного # (пока нет поддержки комментариев)",match:["голос против #","голос против"]},Upvote:{name:"Голос за",description:"Голосует за данный пост или пост названного # (пока нет поддержки комментариев)",match:["голос за #","голос за"]},"Expand All Comments":{name:"Показать все комментарии",description:"Открывает все комментарии к данному посту",match:["показать все комментарии","открыть все комментарии"]}}};

export default Reddit;LS-SPLITallPlugins.Reddit = (() => { const thingAttr=`${PluginBase.util.getNoCollisionUniqueAttr()}-thing`,COMMENTS_REGX=/reddit.com\/r\/[^\/]*\/comments\//;function thingAtIndex(i){return `#siteTable>div.thing[${thingAttr}="${i}"]`}function clickIfExists(selector){const el=document.querySelector(selector);el&&el.click();}var Reddit_280_0_matching_cs_resolved = {...PluginBase,init:async()=>{/^https?:\/\/www.reddit/.test(document.location.href)&&(document.location.href=document.location.href.replace(/^https?:\/\/.*\.reddit.com/,"http://old.reddit.com")),await PluginBase.util.ready();let index=0;for(let el of document.querySelectorAll("#siteTable>div.thing")){index++,el.setAttribute(thingAttr,""+index);const rank=el.querySelector(".rank");rank.setAttribute("style","\n            display: block !important;\n            margin-right: 10px;\n            opacity: 1 !important';\n        "),rank.innerText=""+index;}},commands:{"View Comments":{pageFn:async(transcript,i)=>{clickIfExists(thingAtIndex(i)+" a.comments");}},"Visit Post":{pageFn:async(transcript,i)=>{COMMENTS_REGX.test(window.location.href)?clickIfExists("#siteTable p.title a.title"):clickIfExists(thingAtIndex(i)+" a.title");}},Expand:{pageFn:async(transcript,i)=>{if(void 0!==i){let el=document.querySelector(`${thingAtIndex(i)} .expando-button.collapsed`);el.click(),PluginBase.util.scrollToAnimated(el,-25);}else{const mainItem=document.querySelector("#siteTable .thing .expando-button.collapsed"),commentItems=Array.from(document.querySelectorAll(".commentarea > div > .thing.collapsed"));if(mainItem&&PluginBase.util.isInViewAndTakesSpace(mainItem))mainItem.click();else{let el;for(el of commentItems.reverse())if(PluginBase.util.isInViewAndTakesSpace(el))return void el.querySelector(".comment.collapsed a.expand").click()}}}},Collapse:{pageFn:async(transcript,i)=>{let index=null===i||isNaN(Number(i))?null:Number(i);if(null!==index){document.querySelector(thingAtIndex(index)+" .expando-button:not(.collapsed)").click();}else for(let el of document.querySelectorAll("#siteTable .thing .expando-button.expanded, .commentarea>div>div.thing:not(.collapsed)>div>p>a.expand"))if(PluginBase.util.isInViewAndTakesSpace(el)){el.click();break}}},"Go to Subreddit":{match:{en:input=>{let match=input.match(/\b(?:go to |show )?(?:are|our|r) (.*)/);if(match){const endPos=match.index+match[0].length;return [match.index,endPos,[match[1].replace(/\s/g,"")]]}}},nice:(transcript,matchOutput)=>`go to r/${matchOutput}`,pageFn:async(transcript,subredditName)=>{window.location.href=`https://old.reddit.com/r/${subredditName}`;}},"Go to Reddit":{pageFn:async()=>{document.location.href="https://old.reddit.com";}},"Clear Vote":{pageFn:async(transcript,i)=>{let index=null===i||isNaN(Number(i))?1:Number(i);clickIfExists(`${thingAtIndex(index)} .arrow.downmod,${thingAtIndex(index)} .arrow.upmod`);}},Downvote:{pageFn:async(transcript,i)=>{clickIfExists(`${thingAtIndex(null===i||isNaN(Number(i))?1:Number(i))} .arrow.down:not(.downmod)`);}},Upvote:{pageFn:async(transcript,i)=>{clickIfExists(`${thingAtIndex(null===i||isNaN(Number(i))?1:Number(i))} .arrow.up:not(.upmod)`);}},"Expand All Comments":{pageFn:async()=>{for(let el of document.querySelectorAll(".thing.comment.collapsed a.expand"))el.click();}}}};

return Reddit_280_0_matching_cs_resolved;
 })()LS-SPLITallPlugins.Reddit = (() => { const thingAttr=`${PluginBase.util.getNoCollisionUniqueAttr()}-thing`;var Reddit_280_0_nonmatching_cs_resolved = {...PluginBase,init:async()=>{/^https?:\/\/www.reddit/.test(document.location.href)&&(document.location.href=document.location.href.replace(/^https?:\/\/.*\.reddit.com/,"http://old.reddit.com")),await PluginBase.util.ready();let index=0;for(let el of document.querySelectorAll("#siteTable>div.thing")){index++,el.setAttribute(thingAttr,""+index);const rank=el.querySelector(".rank");rank.setAttribute("style","\n            display: block !important;\n            margin-right: 10px;\n            opacity: 1 !important';\n        "),rank.innerText=""+index;}},commands:{"Go to Reddit":{pageFn:async()=>{document.location.href="https://old.reddit.com";}}}};

return Reddit_280_0_nonmatching_cs_resolved;
 })()