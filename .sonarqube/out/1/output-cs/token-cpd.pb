Ñ
FE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\MessagePublisher.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
RabbitMq$ ,
;, -
internal 
class	 
MessagePublisher 
(  !
IMessageBrokerContext  5
context6 =
)= >
:? @
IMessagePublisherA R
{		 
public

 

async

 
Task

 
PublishAsync

 "
<

" #
T

# $
>

$ %
(

% &
string

& ,
queue

- 2
,

2 3
T

4 5
messageObject

6 C
)

C D
{ 
var 
message 
= 
JsonSerializer $
.$ %
	Serialize% .
(. /
messageObject/ <
)< =
;= >
var 
messagePackage 
= 
Encoding %
.% &
UTF8& *
.* +
GetBytes+ 3
(3 4
message4 ;
); <
;< =
await 
context 
. 
PublishAsync "
(" #
queue# (
,( )
messagePackage* 8
)8 9
.9 :
ConfigureAwait: H
(H I
falseI N
)N O
;O P
} 
} È9
EE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\MessageListener.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
RabbitMq$ ,
;, -
internal 
record	 "
MessageListenerContext &
(& '&
AsyncEventingBasicConsumer' A
ConsumerB J
,J K
AsyncEventHandlerL ]
<] ^!
BasicDeliverEventArgs^ s
>s t
DeliveryHandler	u Ñ
,
Ñ Ö
IList
Ü ã
<
ã å
Action
å í
<
í ì
string
ì ô
>
ô ö
>
ö õ
Handlers
ú §
)
§ •
;
• ¶
internal		 
class			 
MessageListener		 
(		 !
IMessageBrokerContext		 4
context		5 <
)		< =
:		> ?
IMessageListener		@ P
{

 
private 
readonly 

Dictionary 
<  
string  &
,& '"
MessageListenerContext( >
>> ?
_queueHandlers@ N
=O P
[Q R
]R S
;S T
public 

async 
Task 
SubscribeAsync $
($ %
string% +
queue, 1
,1 2
Action3 9
<9 :
string: @
>@ A
messageHandlerB P
)P Q
{ "
MessageListenerContext 
listenerContext .
=/ 0
await1 6%
GetOrCreateMessageContext7 P
(P Q
queueQ V
)V W
.W X
ConfigureAwaitX f
(f g
falseg l
)l m
;m n
listenerContext 
. 
Handlers  
.  !
Add! $
($ %
messageHandler% 3
)3 4
;4 5
} 
public 

void 
Unsubscribe 
( 
string "
queue# (
,( )
Action* 0
<0 1
string1 7
>7 8
messageHandler9 G
)G H
{ "
MessageListenerContext 
? 
listenerContext  /
=0 1
GetMessageContext2 C
(C D
queueD I
)I J
;J K
listenerContext 
? 
. 
Handlers !
.! "
Remove" (
(( )
messageHandler) 7
)7 8
;8 9
} 
private "
MessageListenerContext "
?" #
GetMessageContext$ 5
(5 6
string6 <
queue= B
)B C
{ "
MessageListenerContext 
? 
messageContext  .
;. /
if 

( 
_queueHandlers 
. 
TryGetValue &
(& '
queue' ,
,, -
out. 1
messageContext2 @
)@ A
)A B
{ 	
return 
messageContext !
;! "
}   	
return"" 
messageContext"" 
;"" 
}## 
private%% 
async%% 
Task%% 
<%% "
MessageListenerContext%% -
>%%- .%
GetOrCreateMessageContext%%/ H
(%%H I
string%%I O
queue%%P U
)%%U V
{&& "
MessageListenerContext'' 
?'' 
messageContext''  .
=''/ 0
GetMessageContext''1 B
(''B C
queue''C H
)''H I
;''I J
if(( 

((( 
messageContext(( 
!=(( 
null(( "
)((" #
{)) 	
return** 
messageContext** !
;**! "
}++ 	
if.. 

(.. 
_queueHandlers.. 
... 
TryGetValue.. &
(..& '
queue..' ,
,.., -
out... 1
messageContext..2 @
)..@ A
)..A B
{// 	
return00 
messageContext00 !
;00! "
}11 	
var33 
consumer33 
=33 
new33 &
AsyncEventingBasicConsumer33 5
(335 6
context336 =
.33= >
Channel33> E
)33E F
;33F G
var44 
handlers44 
=44 
new44 
List44 
<44  
Action44  &
<44& '
string44' -
>44- .
>44. /
(44/ 0
)440 1
;441 2
AsyncEventHandler66 
<66 !
BasicDeliverEventArgs66 /
>66/ 0
handler661 8
=669 :
async66; @
(66A B
_66B C
,66C D
package66E L
)66L M
=>66N P
{77 	
try88 
{99 
var:: 
message:: 
=:: 
Encoding:: &
.::& '
UTF8::' +
.::+ ,
	GetString::, 5
(::5 6
package::6 =
.::= >
Body::> B
.::B C
ToArray::C J
(::J K
)::K L
)::L M
;::M N
foreach<< 
(<< 
var<< 
handler<< $
in<<% '
handlers<<( 0
)<<0 1
{== 
handler>> 
(>> 
message>> #
)>># $
;>>$ %
}?? 
awaitAA 
contextAA 
.AA 
ChannelAA %
.AA% &
BasicAckAsyncAA& 3
(AA3 4
packageAA4 ;
.AA; <
DeliveryTagAA< G
,AAG H
multipleAAI Q
:AAQ R
falseAAS X
)AAX Y
.AAY Z
ConfigureAwaitAAZ h
(AAh i
falseAAi n
)AAn o
;AAo p
}BB 
catchCC 
(CC 
	ExceptionCC 
)CC 
{DD 
awaitEE 
contextEE 
.EE 
ChannelEE %
.EE% &
BasicNackAsyncEE& 4
(EE4 5
packageEE5 <
.EE< =
DeliveryTagEE= H
,EEH I
multipleEEJ R
:EER S
falseEET Y
,EEY Z
requeueEE[ b
:EEb c
falseEEd i
)EEi j
.EEj k
ConfigureAwaitEEk y
(EEy z
falseEEz 
)	EE Ä
;
EEÄ Å
throwFF 
;FF 
}GG 
}HH 	
;HH	 

messageContextJJ 
=JJ 
newJJ 
(JJ 
consumerJJ %
,JJ% &
handlerJJ' .
,JJ. /
handlersJJ0 8
)JJ8 9
;JJ9 :
consumerLL 
.LL 
ReceivedAsyncLL 
+=LL !
handlerLL" )
;LL) *
_queueHandlersNN 
.NN 
AddNN 
(NN 
queueNN  
,NN  !
messageContextNN" 0
)NN0 1
;NN1 2
awaitPP 
contextPP 
.PP 
SubscribeAsyncPP $
(PP$ %
queuePP% *
,PP* +
consumerPP, 4
)PP4 5
.PP5 6
ConfigureAwaitPP6 D
(PPD E
falsePPE J
)PPJ K
;PPK L
returnRR 
messageContextRR 
;RR 
}SS 
}TT ©g
JE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\MessageBrokerContext.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
RabbitMq$ ,
;, -
internal 
class	  
MessageBrokerContext #
(# $
IOptions$ ,
<, -
MessageBrokerConfig- @
>@ A
configB H
)H I
:J K!
IMessageBrokerContextL a
{		 
private

 
bool

 
	_disposed

 
=

 
false

 "
;

" #
private 
bool 
_initialized 
= 
false  %
;% &
private 
IConnection 
? 
_connection $
;$ %
private 
IChannel 
? 
_channel 
; 
public 

IChannel 
Channel 
{ 
get 
{ 	
if 
( 
! 
_initialized 
) 
{ 
throw 
new /
#UninitializedMessageBrokerException =
(= >
)> ?
;? @
} 
return 
_channel 
! 
; 
} 	
} 
public 

async 
Task 
InitializeAsync %
(% &
CancellationToken& 7
token8 =
=> ?
default@ G
)G H
{ 
if 

( 
_initialized 
) 
{   	
return!! 
;!! 
}"" 	
var$$ 
factory$$ 
=$$ 
new$$ 
ConnectionFactory$$ +
{%% 	
UserName&& 
=&& 
config&& 
.&& 
Value&& #
.&&# $
UserName&&$ ,
,&&, -
HostName'' 
='' 
config'' 
.'' 
Value'' #
.''# $
HostName''$ ,
,'', -
Password(( 
=(( 
config(( 
.(( 
Value(( #
.((# $
Password(($ ,
,((, -
VirtualHost)) 
=)) 
config))  
.))  !
Value))! &
.))& '
VirtualHost))' 2
,))2 3
}** 	
;**	 

if,, 

(,, 
config,, 
.,, 
Value,, 
.,, 
Port,, 
.,, 
HasValue,, &
),,& '
{-- 	
factory.. 
... 
Port.. 
=.. 
config.. !
...! "
Value.." '
...' (
Port..( ,
..., -
Value..- 2
;..2 3
}// 	
_connection11 
=11 
await11 
factory11 #
.11# $!
CreateConnectionAsync11$ 9
(119 :
token11: ?
)11? @
.11@ A
ConfigureAwait11A O
(11O P
false11P U
)11U V
;11V W
_channel22 
=22 
await22 
_connection22 $
.22$ %
CreateChannelAsync22% 7
(227 8
cancellationToken228 I
:22I J
token22K P
)22P Q
.22Q R
ConfigureAwait22R `
(22` a
false22a f
)22f g
;22g h
_initialized44 
=44 
true44 
;44 
}55 
public77 

async77 
Task77 
CreateQueueAsync77 &
(77& '
string77' -
pipelineName77. :
)77: ;
{88 
var99 
pipelineConfig99 
=99 
GetPipelineConfig99 .
(99. /
pipelineName99/ ;
)99; <
;99< =

Dictionary;; 
<;; 
string;; 
,;; 
object;; !
?;;! "
>;;" #
args;;$ (
=;;) *
new;;+ .
(;;. /
);;/ 0
{<< 	
{== 
$str== 
,== 
$num== #
}==# $
,==$ %
}>> 	
;>>	 

await@@ 
Channel@@ 
.@@ 
QueueDeclareAsync@@ '
(@@' (
pipelineConfigAA 
.AA 
QueueAA  
,AA  !
configBB 
.BB 
ValueBB 
.BB 
CommonQueueSetupBB )
.BB) *
DurableBB* 1
,BB1 2
configCC 
.CC 
ValueCC 
.CC 
CommonQueueSetupCC )
.CC) *
	ExclusiveCC* 3
,CC3 4
configDD 
.DD 
ValueDD 
.DD 
CommonQueueSetupDD )
.DD) *

AutoDeleteDD* 4
,DD4 5
argsEE 
)FF 	
.FF	 

ConfigureAwaitFF
 
(FF 
falseFF 
)FF 
;FF  
awaitHH 
ChannelHH 
.HH  
ExchangeDeclareAsyncHH *
(HH* +
pipelineConfigHH+ 9
.HH9 :
ExchangeHH: B
,HHB C
ExchangeTypeHHD P
.HHP Q
DirectHHQ W
,HHW X
trueHHY ]
,HH] ^
falseHH_ d
)HHd e
.HHe f
ConfigureAwaitHHf t
(HHt u
falseHHu z
)HHz {
;HH{ |
awaitJJ 
ChannelJJ 
.JJ 
QueueBindAsyncJJ $
(JJ$ %
pipelineConfigJJ% 3
.JJ3 4
QueueJJ4 9
,JJ9 :
pipelineConfigJJ; I
.JJI J
ExchangeJJJ R
,JJR S
pipelineConfigJJT b
.JJb c
RouteJJc h
)JJh i
.JJi j
ConfigureAwaitJJj x
(JJx y
falseJJy ~
)JJ~ 
;	JJ Ä
}KK 
publicMM 

asyncMM 
TaskMM 
PublishAsyncMM "
(MM" #
stringMM# )
pipelineNameMM* 6
,MM6 7
byteMM8 <
[MM< =
]MM= >
messagePackageMM? M
)MMM N
{NN 
awaitOO 
CreateQueueAsyncOO 
(OO 
pipelineNameOO +
)OO+ ,
.OO, -
ConfigureAwaitOO- ;
(OO; <
falseOO< A
)OOA B
;OOB C
varQQ 
pipelineConfigQQ 
=QQ 
GetPipelineConfigQQ .
(QQ. /
pipelineNameQQ/ ;
)QQ; <
;QQ< =
BasicPropertiesRR 

propertiesRR "
=RR# $
newRR% (
(RR( )
)RR) *
{SS 	
DeliveryModeTT 
=TT 
DeliveryModesTT (
.TT( )

PersistentTT) 3
,TT3 4
}UU 	
;UU	 

awaitWW 
ChannelWW 
.WW 
BasicPublishAsyncWW '
(WW' (
pipelineConfigWW( 6
.WW6 7
ExchangeWW7 ?
,WW? @
pipelineConfigWWA O
.WWO P
RouteWWP U
,WWU V
	mandatoryWWW `
:WW` a
trueWWb f
,WWf g

propertiesWWh r
,WWr s
messagePackage	WWt Ç
)
WWÇ É
.
WWÉ Ñ
ConfigureAwait
WWÑ í
(
WWí ì
false
WWì ò
)
WWò ô
;
WWô ö
}XX 
publicZZ 

asyncZZ 
TaskZZ 
SubscribeAsyncZZ $
(ZZ$ %
stringZZ% +
pipelineNameZZ, 8
,ZZ8 9
IAsyncBasicConsumerZZ: M
consumerZZN V
)ZZV W
{[[ 
await\\ 
CreateQueueAsync\\ 
(\\ 
pipelineName\\ +
)\\+ ,
.\\, -
ConfigureAwait\\- ;
(\\; <
false\\< A
)\\A B
;\\B C
var]] 
pipelineConfig]] 
=]] 
GetPipelineConfig]] .
(]]. /
pipelineName]]/ ;
)]]; <
;]]< =
await__ 
Channel__ 
.__ 
BasicConsumeAsync__ '
(__' (
pipelineConfig__( 6
.__6 7
Queue__7 <
,__< =
autoAck__> E
:__E F
false__G L
,__L M
consumer__N V
)__V W
.__W X
ConfigureAwait__X f
(__f g
false__g l
)__l m
;__m n
}`` 
publicbb 
!
MessagePipelineConfigbb  
GetPipelineConfigbb! 2
(bb2 3
stringbb3 9
pipelineNamebb: F
)bbF G
{cc 
returndd 
configdd 
.dd 
Valuedd 
.dd 
	Pipelinesdd %
.dd% &
FirstOrDefaultdd& 4
(dd4 5
xdd5 6
=>dd7 9
xdd: ;
.dd; <
Namedd< @
==ddA C
pipelineNameddD P
)ddP Q
??ee 
throwee 
newee /
#InvalidMessageBrokerConfigExceptionee <
(ee< =
$"ee= ?
$stree? N
{eeN O
pipelineNameeeO [
}ee[ \
$stree\ k
"eek l
)eel m
;eem n
}ff 
publichh 

voidhh 
Disposehh 
(hh 
)hh 
{ii 
Disposejj 
(jj 
	disposingjj 
:jj 
truejj 
)jj  
;jj  !
GCkk 

.kk
 
SuppressFinalizekk 
(kk 
thiskk  
)kk  !
;kk! "
}ll 
publicnn 

asyncnn 
	ValueTasknn 
DisposeAsyncnn '
(nn' (
)nn( )
{oo 
awaitpp 
DisposeAsyncCorepp 
(pp 
)pp  
.pp  !
ConfigureAwaitpp! /
(pp/ 0
falsepp0 5
)pp5 6
;pp6 7
Disposerr 
(rr 
	disposingrr 
:rr 
falserr  
)rr  !
;rr! "
GCss 

.ss
 
SuppressFinalizess 
(ss 
thisss  
)ss  !
;ss! "
}tt 
	protectedvv 
virtualvv 
voidvv 
Disposevv "
(vv" #
boolvv# '
	disposingvv( 1
)vv1 2
{ww 
ifxx 

(xx 
	_disposedxx 
)xx 
{yy 	
returnzz 
;zz 
}{{ 	
if}} 

(}} 
	disposing}} 
)}} 
{~~ 	
if 
( 
_channel 
is 
IDisposable '
)' (
{
ÄÄ 
_channel
ÅÅ 
.
ÅÅ 
Dispose
ÅÅ  
(
ÅÅ  !
)
ÅÅ! "
;
ÅÅ" #
_channel
ÇÇ 
=
ÇÇ 
null
ÇÇ 
;
ÇÇ  
}
ÉÉ 
if
ÖÖ 
(
ÖÖ 
_connection
ÖÖ 
is
ÖÖ 
IDisposable
ÖÖ *
)
ÖÖ* +
{
ÜÜ 
_connection
áá 
.
áá 
Dispose
áá #
(
áá# $
)
áá$ %
;
áá% &
_connection
àà 
=
àà 
null
àà "
;
àà" #
}
ââ 
}
ää 	
	_disposed
åå 
=
åå 
true
åå 
;
åå 
}
çç 
	protected
èè 
async
èè 
virtual
èè 
	ValueTask
èè %
DisposeAsyncCore
èè& 6
(
èè6 7
)
èè7 8
{
êê 
if
ëë 

(
ëë 
_channel
ëë 
is
ëë 
not
ëë 
null
ëë  
)
ëë  !
{
íí 	
await
ìì 
_channel
ìì 
.
ìì 

CloseAsync
ìì %
(
ìì% &
)
ìì& '
.
ìì' (
ConfigureAwait
ìì( 6
(
ìì6 7
false
ìì7 <
)
ìì< =
;
ìì= >
await
îî 
_channel
îî 
.
îî 
DisposeAsync
îî '
(
îî' (
)
îî( )
.
îî) *
ConfigureAwait
îî* 8
(
îî8 9
false
îî9 >
)
îî> ?
;
îî? @
_channel
ïï 
=
ïï 
null
ïï 
;
ïï 
}
ññ 	
if
òò 

(
òò 
_connection
òò 
is
òò 
not
òò 
null
òò #
)
òò# $
{
ôô 	
await
öö 
_connection
öö 
.
öö 

CloseAsync
öö (
(
öö( )
)
öö) *
.
öö* +
ConfigureAwait
öö+ 9
(
öö9 :
false
öö: ?
)
öö? @
;
öö@ A
await
õõ 
_connection
õõ 
.
õõ 
DisposeAsync
õõ *
(
õõ* +
)
õõ+ ,
.
õõ, -
ConfigureAwait
õõ- ;
(
õõ; <
false
õõ< A
)
õõA B
;
õõB C
_connection
úú 
=
úú 
null
úú 
;
úú 
}
ùù 	
}
ûû 
~
†† "
MessageBrokerContext
†† 
(
†† 
)
†† 
=>
†† 
Dispose
†† &
(
††& '
	disposing
††' 0
:
††0 1
false
††2 7
)
††7 8
;
††8 9
}°° Ã$
CE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\MessageBroker.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
RabbitMq$ ,
;, -
internal 
class	 
MessageBroker 
( !
IMessageBrokerContext 2
context3 :
,: ;
IMessageListener< L
listenerM U
,U V
IMessagePublisherW h
	publisheri r
)r s
:t u
IMessageBroker	v Ñ
{ 
private 
bool 
	_disposed 
= 
false "
;" #
public 

Task 
InitializeAsync 
(  
CancellationToken  1
token2 7
=8 9
default: A
)A B
{ 
return		 
context		 
.		 
InitializeAsync		 &
(		& '
token		' ,
)		, -
;		- .
}

 
public 

Task 
SubscribeAsync 
( 
string %
queue& +
,+ ,
Action- 3
<3 4
string4 :
>: ;
messageHandler< J
)J K
{ 
return 
listener 
. 
SubscribeAsync &
(& '
queue' ,
,, -
messageHandler. <
)< =
;= >
} 
public 

void 
Unsubscribe 
( 
string "
queue# (
,( )
Action* 0
<0 1
string1 7
>7 8
messageHandler9 G
)G H
{ 
listener 
. 
Unsubscribe 
( 
queue "
," #
messageHandler$ 2
)2 3
;3 4
} 
public 

Task 
PublishAsync 
< 
T 
> 
(  
string  &
queue' ,
,, -
T. /
messageObject0 =
)= >
{ 
return 
	publisher 
. 
PublishAsync %
(% &
queue& +
,+ ,
messageObject- :
): ;
;; <
} 
public 

void 
Dispose 
( 
) 
{ 
Dispose 
( 
	disposing 
: 
true 
)  
;  !
GC 

.
 
SuppressFinalize 
( 
this  
)  !
;! "
} 
public!! 

async!! 
	ValueTask!! 
DisposeAsync!! '
(!!' (
)!!( )
{"" 
await## 
DisposeAsyncCore## 
(## 
)##  
.##  !
ConfigureAwait##! /
(##/ 0
false##0 5
)##5 6
;##6 7
Dispose%% 
(%% 
	disposing%% 
:%% 
false%%  
)%%  !
;%%! "
GC&& 

.&&
 
SuppressFinalize&& 
(&& 
this&&  
)&&  !
;&&! "
}'' 
	protected)) 
virtual)) 
void)) 
Dispose)) "
())" #
bool))# '
	disposing))( 1
)))1 2
{** 
if++ 

(++ 
	_disposed++ 
)++ 
{,, 	
return-- 
;-- 
}.. 	
if00 

(00 
	disposing00 
)00 
{11 	
context22 
.22 
Dispose22 
(22 
)22 
;22 
}33 	
	_disposed55 
=55 
true55 
;55 
}66 
	protected88 
async88 
virtual88 
	ValueTask88 %
DisposeAsyncCore88& 6
(886 7
)887 8
{99 
if:: 

(:: 
	_disposed:: 
):: 
{;; 	
return<< 
;<< 
}== 	
await?? 
context?? 
.?? 
DisposeAsync?? "
(??" #
)??# $
.??$ %
ConfigureAwait??% 3
(??3 4
false??4 9
)??9 :
;??: ;
}@@ 
~CC 
MessageBrokerCC 
(CC 
)CC 
=>CC 
DisposeCC 
(CC  
	disposingCC  )
:CC) *
falseCC+ 0
)CC0 1
;CC1 2
}DD €
KE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\IMessageBrokerContext.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
RabbitMq$ ,
;, -
internal 
	interface	 !
IMessageBrokerContext (
:) *
IDisposable+ 6
,6 7
IAsyncDisposable8 H
{ 
IChannel 
Channel 
{ 
get 
; 
} 
Task		 
InitializeAsync			 
(		 
CancellationToken		 *
token		+ 0
=		1 2
default		3 :
)		: ;
;		; <
Task 
PublishAsync	 
( 
string 
pipelineName )
,) *
byte+ /
[/ 0
]0 1
message2 9
)9 :
;: ;
Task 
SubscribeAsync	 
( 
string 
pipelineName +
,+ ,
IAsyncBasicConsumer- @
consumerA I
)I J
;J K
} D
BE:\repos\e-shop\EShop.MessageBrokerClient\RabbitMq\GlobalUsings.csÈ
>E:\repos\e-shop\EShop.MessageBrokerClient\IMessagePublisher.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
;# $
public 
	interface 
IMessagePublisher "
{ 
Task 
PublishAsync	 
< 
T 
> 
( 
string 
queue  %
,% &
T' (
message) 0
)0 1
;1 2
} Í
=E:\repos\e-shop\EShop.MessageBrokerClient\IMessageListener.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
;# $
public 
	interface 
IMessageListener !
{ 
Task 
SubscribeAsync	 
( 
string 
queue $
,$ %
Action& ,
<, -
string- 3
>3 4
messageHandler5 C
)C D
;D E
void 
Unsubscribe	 
( 
string 
queue !
,! "
Action# )
<) *
string* 0
>0 1
messageHandler2 @
)@ A
;A B
} ˘
;E:\repos\e-shop\EShop.MessageBrokerClient\IMessageBroker.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
;# $
public 
	interface 
IMessageBroker 
:  !
IMessageListener" 2
,2 3
IMessagePublisher4 E
,E F
IDisposableG R
,R S
IAsyncDisposableT d
{ 
public 

Task 
InitializeAsync 
(  
CancellationToken  1
token2 7
=8 9
default: A
)A B
;B C
} œ
[E:\repos\e-shop\EShop.MessageBrokerClient\Exceptions\UninitializedMessageBrokerException.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $

Exceptions$ .
;. /
public 
class /
#UninitializedMessageBrokerException 0
(0 1
)1 2
: 
	Exception 
( 
$str T
)T U
{ 
}  
[E:\repos\e-shop\EShop.MessageBrokerClient\Exceptions\InvalidMessageBrokerConfigException.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $

Exceptions$ .
;. /
public 
class /
#InvalidMessageBrokerConfigException 0
(0 1
string1 7
reason8 >
)> ?
:@ A
	ExceptionB K
(K L
$"L N
$str	N Ä
{
Ä Å
reason
Å á
}
á à
"
à â
)
â ä
;
ä ãÍ
@E:\repos\e-shop\EShop.MessageBrokerClient\DependencyInjection.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
;# $
public		 
static		 
class		 
DependencyInjection		 '
{

 
public 

static 
IServiceCollection $
AddMessageBroker% 5
(5 6
this6 :
IServiceCollection; M
servicesN V
,V W
IConfigurationX f
configg m
)m n
{ 
services 
. 
	Configure 
< 
MessageBrokerConfig .
>. /
(/ 0
config0 6
.6 7

GetSection7 A
(A B
$strB W
)W X
)X Y
;Y Z
services 
. 
AddTransient 
< 
IMessageListener .
,. /
MessageListener0 ?
>? @
(@ A
)A B
;B C
services 
. 
AddTransient 
< 
IMessagePublisher /
,/ 0
MessagePublisher1 A
>A B
(B C
)C D
;D E
services 
. 
AddSingleton 
< !
IMessageBrokerContext 3
,3 4 
MessageBrokerContext5 I
>I J
(J K
)K L
;L M
services 
. 
AddSingleton 
< 
IMessageBroker ,
,, -
MessageBroker. ;
>; <
(< =
)= >
;> ?
return 
services 
; 
} 
} §
PE:\repos\e-shop\EShop.MessageBrokerClient\Configuration\MessagePipelineConfig.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
Configuration$ 1
;1 2
public 
record !
MessagePipelineConfig #
(# $
string$ *
Name+ /
,/ 0
string1 7
Queue8 =
,= >
string? E
ExchangeF N
,N O
stringP V
RouteW \
)\ ]
;] ^˝
NE:\repos\e-shop\EShop.MessageBrokerClient\Configuration\MessageBrokerConfig.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
Configuration$ 1
;1 2
public 
record 
MessageBrokerConfig !
{ 
public 

required 
string 
UserName #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 

required 
string 
Password #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 

required 
string 
HostName #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 

required 
string 
VirtualHost &
{' (
get) ,
;, -
init. 2
;2 3
}4 5
public		 

int		 
?		 
Port		 
{		 
get		 
;		 
init		  
;		  !
}		" #
public 

required 
CommonQueueSetup $
CommonQueueSetup% 5
{6 7
get8 ;
;; <
init= A
;A B
}C D
public 

required 
IReadOnlyCollection '
<' (!
MessagePipelineConfig( =
>= >
	Pipelines? H
{I J
getK N
;N O
initP T
;T U
}V W
} °
KE:\repos\e-shop\EShop.MessageBrokerClient\Configuration\CommonQueueSetup.cs
	namespace 	
EShop
 
. 
MessageBrokerClient #
.# $
Configuration$ 1
;1 2
public 
record 
CommonQueueSetup 
{ 
public 

bool 
Durable 
{ 
get 
; 
init #
;# $
}% &
=' (
true) -
;- .
public 

bool 
	Exclusive 
{ 
get 
;  
init! %
;% &
}' (
=) *
false+ 0
;0 1
public 

bool 

AutoDelete 
{ 
get  
;  !
init" &
;& '
}( )
=* +
false, 1
;1 2
} 