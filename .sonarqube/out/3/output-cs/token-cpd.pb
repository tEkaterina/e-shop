â
6E:\repos\e-shop\CartService\WebApi\OpenApiExtension.cs
	namespace 	
CartService
 
. 
WebApi 
; 
public 
static 
class 
OpenApiExtension $
{ 
public 

static 
void  
AddOpenApiGeneration +
(+ ,
this, 0
IServiceCollection1 C
servicesD L
)L M
{ 
services		 
.		 #
AddVersionedApiExplorer		 (
(		( )
options		) 0
=>		1 3
{

 	
options 
. 
DefaultApiVersion %
=& '
new( +

ApiVersion, 6
(6 7
$num7 8
,8 9
$num: ;
); <
;< =
options 
. 
GroupNameFormat #
=$ %
$str& .
;. /
options 
. /
#AssumeDefaultVersionWhenUnspecified 7
=8 9
true: >
;> ?
} 	
)	 

;
 
Version 
[ 
] 
versions 
= 
[ 
new !
Version" )
() *
$num* +
,+ ,
$num- .
). /
,/ 0
new1 4
Version5 <
(< =
$num= >
,> ?
$num@ A
)A B
]B C
;C D
foreach 
( 
var 
version 
in 
versions  (
)( )
{ 	
services 
. 
AddOpenApiDocument '
(' (
options( /
=>0 2
{ 
options 
. 
DocumentName $
=% &
$str' *
++ ,
version- 4
.4 5
Major5 :
;: ;
options 
. 
ApiGroupNames %
=& '
[( )
$str) ,
+- .
version/ 6
.6 7
Major7 <
]< =
;= >
options 
. 
Version 
=  !
version" )
.) *
Major* /
+0 1
$str2 5
+6 7
version8 ?
.? @
Minor@ E
;E F
} 
) 
; 
} 	
} 
public 

static 
void 

AddSwagger !
(! "
this" &
IApplicationBuilder' :
app; >
)> ?
{ 
app 
. 

UseOpenApi 
( 
) 
; 
app   
.   
UseSwaggerUi   
(   
)   
;   
}!! 
}"" ˆ?
AE:\repos\e-shop\CartService\WebApi\Controllers\CartsController.cs
	namespace		 	
CartService		
 
.		 
WebApi		 
.		 
Controllers		 (
;		( )
public 
record 
CreateCartRequest 
(  
string  &
Id' )
)) *
;* +
[ 
Route 
( 
$str 
) 
] 
[ 

ApiVersion 
( 
$str 
) 
] 
[ 

ApiVersion 
( 
$str 
) 
] 
[ 
ApiController 
] 
public 
class 
CartsController 
( 
ICartService )
_cartService* 6
,6 7
IProductService8 G
_productServiceH W
)W X
:Y Z
ControllerBase[ i
{ 
[ 

ApiVersion 
( 
$str 
) 
] 
[ 
MapToApiVersion 
( 
$str 
) 
] 
[ 
HttpGet 
( 
$str 
) 
] 
public 

IActionResult 
GetCartProducts (
(( )
string) /
id0 2
)2 3
{ 
try 
{   	
CartDto!! 
cart!! 
=!! 
_cartService!! '
.!!' (
Get!!( +
(!!+ ,
id!!, .
)!!. /
;!!/ 0
return"" 
Ok"" 
("" 
cart"" 
."" 
Products"" #
)""# $
;""$ %
}## 	
catch$$ 
($$ 
NotFoundException$$  
)$$  !
{%% 	
return&& 
NotFound&& 
(&& 
$str&& @
+&&A B
id&&C E
)&&E F
;&&F G
}'' 	
}(( 
[11 

ApiVersion11 
(11 
$str11 
)11 
]11 
[22 
MapToApiVersion22 
(22 
$str22 
)22 
]22 
[33 
HttpGet33 
(33 
$str33 
)33 
]33 
public44 

IActionResult44 
Get44 
(44 
string44 #
id44$ &
)44& '
{55 
try66 
{77 	
CartDto88 
cart88 
=88 
_cartService88 '
.88' (
Get88( +
(88+ ,
id88, .
)88. /
;88/ 0
return99 
Ok99 
(99 
cart99 
)99 
;99 
}:: 	
catch;; 
(;; 
NotFoundException;;  
);;  !
{<< 	
return== 
NotFound== 
(== 
$str== @
+==A B
id==C E
)==E F
;==F G
}>> 	
}?? 
[GG 
HttpPostGG 
]GG 
publicHH 

IActionResultHH 
PostHH 
(HH 
[HH 
FromBodyHH '
]HH' (
CreateCartRequestHH) :
requestHH; B
)HHB C
{II 
CartDtoJJ 
cartJJ 
=JJ 
_cartServiceJJ #
.JJ# $
GetOrCreateJJ$ /
(JJ/ 0
requestJJ0 7
.JJ7 8
IdJJ8 :
)JJ: ;
;JJ; <
returnLL 
OkLL 
(LL 
cartLL 
)LL 
;LL 
}MM 
[UU 

HttpDeleteUU 
(UU 
$strUU 
)UU 
]UU 
publicVV 

IActionResultVV 
DeleteVV 
(VV  
stringVV  &
idVV' )
)VV) *
{WW 
tryXX 
{YY 	
ifZZ 
(ZZ 
!ZZ 
_cartServiceZZ 
.ZZ 
DeleteZZ $
(ZZ$ %
idZZ% '
)ZZ' (
)ZZ( )
{[[ 
return\\ 
NotFound\\ 
(\\  
id\\  "
)\\" #
;\\# $
}]] 
return__ 
Ok__ 
(__ 
)__ 
;__ 
}`` 	
catchaa 
(aa 
NotFoundExceptionaa  
)aa  !
{bb 	
returncc 
NotFoundcc 
(cc 
idcc 
)cc 
;cc  
}dd 	
}ee 
[nn 
HttpGetnn 
(nn 
$strnn  
)nn  !
]nn! "
publicoo 

IActionResultoo 
GetProductsoo $
(oo$ %
stringoo% +
cartIdoo, 2
)oo2 3
{pp 
tryqq 
{rr 	
CartDtoss 
cartss 
=ss 
_cartServicess '
.ss' (
Getss( +
(ss+ ,
cartIdss, 2
)ss2 3
;ss3 4
returntt 
Oktt 
(tt 
carttt 
.tt 
Productstt #
)tt# $
;tt$ %
}uu 	
catchvv 
(vv 
NotFoundExceptionvv  
)vv  !
{ww 	
returnxx 
NotFoundxx 
(xx 
$strxx @
+xxA B
cartIdxxC I
)xxI J
;xxJ K
}yy 	
}zz 
[
„„ 
HttpPost
„„ 
(
„„ 
$str
„„ !
)
„„! "
]
„„" #
public
…… 

IActionResult
…… 

AddProduct
…… #
(
……# $
string
……$ *
cartId
……+ 1
,
……1 2
[
……3 4
FromBody
……4 <
]
……< =

ProductDto
……> H
request
……I P
)
……P Q
{
†† 
try
‡‡ 
{
ˆˆ 	
_productService
‰‰ 
.
‰‰ !
CreateOrSaveProduct
‰‰ /
(
‰‰/ 0
request
‰‰0 7
)
‰‰7 8
;
‰‰8 9
CartDto
ŠŠ 
cart
ŠŠ 
=
ŠŠ 
_cartService
ŠŠ '
.
ŠŠ' (

AddProduct
ŠŠ( 2
(
ŠŠ2 3
cartId
ŠŠ3 9
,
ŠŠ9 :
request
ŠŠ; B
.
ŠŠB C
Id
ŠŠC E
,
ŠŠE F
request
ŠŠG N
.
ŠŠN O
Count
ŠŠO T
)
ŠŠT U
;
ŠŠU V
return
‹‹ 
Ok
‹‹ 
(
‹‹ 
cart
‹‹ 
.
‹‹ 
Products
‹‹ #
)
‹‹# $
;
‹‹$ %
}
ŒŒ 	
catch
 
(
 
NotFoundException
  
)
  !
{
ŽŽ 	
return
 
NotFound
 
(
 
$str
 D
+
E F
request
G N
.
N O
Id
O Q
)
Q R
;
R S
}
 	
}
‘‘ 
[
›› 

HttpDelete
›› 
(
›› 
$str
›› /
)
››/ 0
]
››0 1
public
œœ 

IActionResult
œœ 
RemoveProduct
œœ &
(
œœ& '
string
œœ' -
cartId
œœ. 4
,
œœ4 5
int
œœ6 9
	productId
œœ: C
,
œœC D
[
œœE F
	FromQuery
œœF O
]
œœO P
int
œœQ T
?
œœT U
count
œœV [
)
œœ[ \
{
 
try
žž 
{
ŸŸ 	
_cartService
   
.
   
DeleteProduct
   &
(
  & '
cartId
  ' -
,
  - .
	productId
  / 8
,
  8 9
count
  : ?
)
  ? @
;
  @ A
return
¡¡ 
	NoContent
¡¡ 
(
¡¡ 
)
¡¡ 
;
¡¡ 
}
¢¢ 	
catch
££ 
(
££ 
NotFoundException
££  
)
££  !
{
¤¤ 	
return
¥¥ 
NotFound
¥¥ 
(
¥¥ 
cartId
¥¥ "
)
¥¥" #
;
¥¥# $
}
¦¦ 	
}
§§ 
}¨¨ ­
>E:\repos\e-shop\CartService\Services\Product\ProductService.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
;& '
internal		 
class			 
ProductService		 
(		 
IProductRepository		 0

repository		1 ;
,		; <
IProductMapper		= K
mapper		L R
)		R S
:		T U
IProductService		V e
{

 
public 


ProductDto 

GetProduct  
(  !
int! $
	productId% .
). /
{ 
ProductEntity 
? 
product 
=  

repository! +
.+ ,

GetProduct, 6
(6 7
	productId7 @
)@ A
;A B
Guard 
. 
Against 
. 
NotFound 
( 
	productId (
,( )
product* 1
)1 2
;2 3
return 
mapper 
. 
ToProductDto "
(" #
product# *
)* +
;+ ,
} 
public 

void 
CreateOrSaveProduct #
(# $

ProductDto$ .
product/ 6
)6 7
{ 
ProductEntity 
mappedProduct #
=$ %
mapper& ,
., -
	ToProduct- 6
(6 7
product7 >
)> ?
;? @

repository 
. 
SaveProduct 
( 
mappedProduct ,
), -
;- .
} 
} É
EE:\repos\e-shop\CartService\Services\Product\ProductChangeListener.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
;& '
internal 
class	 !
ProductChangeListener $
($ %#
IProductChangePublisher% <
changePublisher= L
,L M
IProductRepositoryN `

repositorya k
)k l
:m n#
IProductChangeListener	o …
{ 
public		 

Task		 

StartAsync		 
(		 
CancellationToken		 ,
cancellationToken		- >
)		> ?
{

 
changePublisher 
. 
OnProductChanged (
+=) +$
HandleProductChangeAsync, D
;D E
return 
Task 
. 
CompletedTask !
;! "
} 
public 

Task 
	StopAsync 
( 
CancellationToken +
cancellationToken, =
)= >
{ 
changePublisher 
. 
OnProductChanged (
-=) +$
HandleProductChangeAsync, D
;D E
return 
Task 
. 
CompletedTask !
;! "
} 
private 
void $
HandleProductChangeAsync )
() *
object* 0
?0 1
source2 8
,8 9
ProductChangeEvent: L
eventPayloadM Y
)Y Z
{ 
var 
existingProductId 
= 
eventPayload  ,
., -
	ProductId- 6
;6 7
ProductEntity 
? 
existingProduct &
=' (

repository) 3
.3 4

GetProduct4 >
(> ?
existingProductId? P
)P Q
;Q R
if 

( 
existingProduct 
!= 
null #
)# $
{ 	
var 
updatedProduct 
=  
existingProduct! 0
with1 5
{ 
Description 
= 
eventPayload *
.* +
Details+ 2
.2 3
Description3 >
,> ?
Image 
= 
eventPayload $
.$ %
Details% ,
., -
Image- 2
,2 3
Name   
=   
eventPayload   #
.  # $
Details  $ +
.  + ,
Name  , 0
,  0 1
Price!! 
=!! 
eventPayload!! $
.!!$ %
Details!!% ,
.!!, -
Price!!- 2
,!!2 3
}"" 
;"" 

repository$$ 
.$$ 
SaveProduct$$ "
($$" #
updatedProduct$$# 1
)$$1 2
;$$2 3
}%% 	
}&& 
}'' ™
EE:\repos\e-shop\CartService\Services\Product\Mappers\ProductMapper.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
.& '
Mappers' .
;. /
internal 
class	 
ProductMapper 
: 
IProductMapper -
{ 
public 

ProductEntity 
	ToProduct "
(" #

ProductDto# -

productDto. 8
)8 9
{		 
return

 
new

 
ProductEntity

  
(

  !

productDto

! +
.

+ ,
Id

, .
)

. /
{ 	
Name 
= 

productDto 
. 
Name "
," #
Description 
= 

productDto $
.$ %
Description% 0
,0 1
Image 
= 

productDto 
. 
Image $
,$ %
Price 
= 

productDto 
. 
Price $
,$ %
} 	
;	 

} 
public 


ProductDto 
ToProductDto "
(" #
ProductEntity# 0
product1 8
)8 9
{ 
return 
new 

ProductDto 
( 
product %
.% &
Id& (
,( )
product* 1
.1 2
Name2 6
)6 7
{ 	
Description 
= 
product !
.! "
Description" -
,- .
Image 
= 
product 
. 
Image !
,! "
Price 
= 
product 
. 
Price !
,! "
} 	
;	 

} 
} ¨
FE:\repos\e-shop\CartService\Services\Product\Mappers\IProductMapper.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
.& '
Mappers' .
{ 
public 

	interface 
IProductMapper #
{ 
public 

ProductDto 
ToProductDto &
(& '
ProductEntity' 4
product5 <
)< =
;= >
public

 
ProductEntity

 
	ToProduct

 &
(

& '

ProductDto

' 1

productDto

2 <
)

< =
;

= >
} 
} Ê
?E:\repos\e-shop\CartService\Services\Product\IProductService.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
{ 
public 

	interface 
IProductService $
{ 

ProductDto 

GetProduct 
( 
int !
	productId" +
)+ ,
;, -
void		 
CreateOrSaveProduct		  
(		  !

ProductDto		! +
product		, 3
)		3 4
;		4 5
}

 
} à
FE:\repos\e-shop\CartService\Services\Product\IProductChangeListener.cs
	namespace 	
CartService
 
. 
Services 
. 
Product &
;& '
public 
	interface "
IProductChangeListener '
:( )
IHostedService* 8
{ 
} 6
4E:\repos\e-shop\CartService\Services\GlobalUsings.cs¢#
TE:\repos\e-shop\CartService\Services\Events\ProductChanged\ProductChangePublisher.cs
	namespace 	
CartService
 
. 
Services 
. 
Events %
.% &
ProductChanged& 4
;4 5
internal 
class	 "
ProductChangePublisher %
(% &
IMessageBroker& 4
messageBroker5 B
)B C
:D E#
IProductChangePublisherF ]
{ 
private		 
EventHandler		 
<		 
ProductChangeEvent		 +
>		+ ,
?		, -
_handler		. 6
;		6 7
private

 
readonly

 
bool

 
_subscribed

 %
=

& '
false

( -
;

- .
private 
readonly 
object 
_lock !
=" #
new$ '
object( .
(. /
)/ 0
;0 1
private 
bool 
	_disposed 
= 
false "
;" #
public 

event 
EventHandler 
< 
ProductChangeEvent 0
>0 1
OnProductChanged2 B
{ 
add 
{ 	
lock 
( 
_lock 
) 
{ 
SubscribeOnQueue  
(  !
)! "
;" #
_handler 
+= 
value !
;! "
} 
} 	
remove 
{ 	
lock 
( 
_lock 
) 
{ 
_handler 
-= 
value !
;! "
} 
} 	
} 
public!! 

void!! 
Dispose!! 
(!! 
)!! 
{"" 
if## 

(## 
	_disposed## 
)## 
return## 
;## 
Dispose%% 
(%% 
	disposing%% 
:%% 
true%% 
)%%  
;%%  !
GC&& 

.&&
 
SuppressFinalize&& 
(&& 
this&&  
)&&  !
;&&! "
	_disposed(( 
=(( 
true(( 
;(( 
})) 
private++ 
Task++ 
SubscribeOnQueue++ !
(++! "
)++" #
{,, 
if-- 

(-- 
_subscribed-- 
)-- 
{.. 	
return// 
Task// 
.// 
CompletedTask// %
;//% &
}00 	
return22 
messageBroker22 
.22 
SubscribeAsync22 +
(22+ ,
ProductChangeConst22, >
.22> ?
	QueueName22? H
,22H I 
HandleProductPublish22J ^
)22^ _
;22_ `
}33 
private55 
void55  
HandleProductPublish55 %
(55% &
string55& ,
message55- 4
)554 5
{66 
var77 
payload77 
=77 
JsonSerializer77 $
.77$ %
Deserialize77% 0
<770 1
ProductChangeEvent771 C
>77C D
(77D E
message77E L
)77L M
??88 
throw88 
new88 "
ProductChangeException88 /
(88/ 0
$str880 a
)88a b
;88b c
_handler:: 
?:: 
.:: 
Invoke:: 
(:: 
this:: 
,:: 
payload:: &
)::& '
;::' (
};; 
private== 
void== 
Dispose== 
(== 
bool== 
	disposing== '
)==' (
{>> 
if?? 

(?? 
	disposing?? 
)?? 
{@@ 	
ifAA 
(AA 
_subscribedAA 
)AA 
{BB 
messageBrokerCC 
.CC 
UnsubscribeCC )
(CC) *
ProductChangeConstCC* <
.CC< =
	QueueNameCC= F
,CCF G 
HandleProductPublishCCH \
)CC\ ]
;CC] ^
}DD 
_handlerFF 
=FF 
nullFF 
;FF 
}GG 	
}HH 
~JJ "
ProductChangePublisherJJ 
(JJ 
)JJ 
=>JJ  
DisposeJJ! (
(JJ( )
	disposingJJ) 2
:JJ2 3
falseJJ4 9
)JJ9 :
;JJ: ;
}KK Ë
TE:\repos\e-shop\CartService\Services\Events\ProductChanged\ProductChangeException.cs
	namespace 	
CartService
 
. 
Services 
. 
Events %
.% &
ProductChanged& 4
;4 5
public 
class "
ProductChangeException #
(# $
string$ *
reason+ 1
)1 2
:3 4
	Exception5 >
(> ?
$"? A
$strA h
{h i
reasoni o
}o p
"p q
)q r
;r sû	
PE:\repos\e-shop\CartService\Services\Events\ProductChanged\ProductChangeEvent.cs
	namespace 	
CartService
 
. 
Services 
. 
Events %
.% &
ProductChanged& 4
;4 5
public 
record 
ProductChangeEvent  
(  !
int! $
	ProductId% .
,. / 
ProductChangeDetails0 D
DetailsE L
)L M
;M N
public 
record  
ProductChangeDetails "
{ 
public 

required 
string 
Name 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 

required 
decimal 
Price !
{" #
get$ '
;' (
set) ,
;, -
}. /
public		 

string		 
?		 
Description		 
{		  
get		! $
;		$ %
init		& *
;		* +
}		, -
public

 

string

 
?

 
Image

 
{

 
get

 
;

 
set

  #
;

# $
}

% &
} ø
PE:\repos\e-shop\CartService\Services\Events\ProductChanged\ProductChangeConst.cs
	namespace 	
CartService
 
. 
Services 
. 
Events %
.% &
ProductChanged& 4
;4 5
public 
static 
class 
ProductChangeConst &
{ 
public 

static 
string 
	QueueName "
=# $
$str% 7
;7 8
} ±
UE:\repos\e-shop\CartService\Services\Events\ProductChanged\IProductChangePublisher.cs
	namespace 	
CartService
 
. 
Services 
. 
Events %
.% &
ProductChanged& 4
;4 5
internal 
	interface	 #
IProductChangePublisher *
:+ ,
IDisposable- 8
{ 
event 	
EventHandler
 
< 
ProductChangeEvent )
>) *
OnProductChanged+ ;
;; <
} ¨
;E:\repos\e-shop\CartService\Services\DependencyInjection.cs
	namespace 	
CartService
 
. 
Services 
; 
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
IServiceCollection $"
AddApplicationServices% ;
(; <
this< @
IServiceCollectionA S
servicesT \
)\ ]
{ 
services 
. 
AddTransient 
< 
ICartService *
,* +
Cart, 0
.0 1
CartService1 <
>< =
(= >
)> ?
;? @
services 
. 
AddTransient 
< 
ICartMapper )
,) *

CartMapper+ 5
>5 6
(6 7
)7 8
;8 9
services 
. 
AddTransient 
< 
IProductMapper ,
,, -
ProductMapper. ;
>; <
(< =
)= >
;> ?
services 
. 
AddTransient 
< 
IProductService -
,- .
ProductService/ =
>= >
(> ?
)? @
;@ A
services 
. 
AddHostedService !
<! "!
ProductChangeListener" 7
>7 8
(8 9
)9 :
;: ;
services 
. 
AddSingleton 
< #
IProductChangePublisher 5
,5 6"
ProductChangePublisher7 M
>M N
(N O
)O P
;P Q
return 
services 
; 
} 
} ã
ME:\repos\e-shop\CartService\Services\Common\Exceptions\CartCreateException.cs
	namespace 	
CartService
 
. 
Services 
. 
Common %
.% &

Exceptions& 0
{ 
public 

class 
CartCreateException $
($ %
string% +
id, .
). /
:0 1
	Exception2 ;
(; <
$"< >
$str> T
{T U
idU W
}W X
$strX Y
"Y Z
)Z [
{ 
} 
} Ê
=E:\repos\e-shop\CartService\Services\Common\Dto\ProductDto.cs
	namespace 	
CartService
 
. 
Services 
. 
Common %
.% &
Dto& )
{ 
public 

record 

ProductDto 
( 
int  
Id! #
,# $
string% +
Name, 0
)0 1
{ 
public 
int 
Count 
{ 
get 
; 
set  #
;# $
}% &
public 
string 
? 
Description "
{# $
get% (
;( )
init* .
;. /
}0 1
public		 
string		 
?		 
Image		 
{		 
get		 "
;		" #
init		$ (
;		( )
}		* +
public 
decimal 
Price 
{ 
get "
;" #
init$ (
;( )
}* +
} 
} Œ
:E:\repos\e-shop\CartService\Services\Common\Dto\CartDto.cs
	namespace 	
CartService
 
. 
Services 
. 
Common %
.% &
Dto& )
;) *
public 
record 
CartDto 
( 
string 
Id 
)  
{ 
public 

IEnumerable 
< 

ProductDto !
>! "
Products# +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
=; <
[= >
]> ?
;? @
} ‡
@E:\repos\e-shop\CartService\Services\Cart\Mappers\ICartMapper.cs
	namespace 	
CartService
 
. 
Services 
. 
Cart #
.# $
Mappers$ +
;+ ,
public 
	interface 
ICartMapper 
{ 

CartEntity 
ToCart 
( 
CartDto 
cartDto %
)% &
;& '
AddedProductEntity		 
ToAddedProduct		 %
(		% &

ProductDto		& 0

productDto		1 ;
)		; <
;		< =
CartDto 
	ToCartDto 
( 

CartEntity  
cart! %
)% &
;& '

ProductDto 
? 
ToProductDto 
( 
AddedProductEntity /
product0 7
)7 8
;8 9
} É
?E:\repos\e-shop\CartService\Services\Cart\Mappers\CartMapper.cs
	namespace 	
CartService
 
. 
Services 
. 
Cart #
.# $
Mappers$ +
;+ ,
public 
class 

CartMapper 
( 
IProductService '
productService( 6
)6 7
:8 9
ICartMapper: E
{ 
private		 
readonly		 
IProductService		 $
_productService		% 4
=		5 6
productService		7 E
;		E F
public 


CartEntity 
ToCart 
( 
CartDto $
cartDto% ,
), -
{ 
return 
new 

CartEntity 
( 
cartDto %
.% &
Id& (
)( )
{ 	
Products 
= 
cartDto 
. 
Products '
.' (
Select( .
(. /
ToAddedProduct/ =
)= >
.> ?
ToList? E
(E F
)F G
,G H
} 	
;	 

} 
public 

AddedProductEntity 
ToAddedProduct ,
(, -

ProductDto- 7

productDto8 B
)B C
{ 
return 
new 
AddedProductEntity %
{& '
	ProductId( 1
=2 3

productDto4 >
.> ?
Id? A
,A B
CountC H
=I J

productDtoK U
.U V
CountV [
}\ ]
;] ^
} 
public 

CartDto 
	ToCartDto 
( 

CartEntity '
cart( ,
), -
{ 
IEnumerable 
< 

ProductDto 
> 
products  (
;( )
if 

( 
cart 
. 
Products 
. 
Count 
>  !
$num" #
)# $
{ 	
var 
mappedProducts 
=  
cart! %
.% &
Products& .
.. /
Select/ 5
(5 6
ToProductDto6 B
)B C
;C D
products 
= 
mappedProducts %
.% &
Where& +
(+ ,
x, -
=>. 0
x1 2
!=3 5
null6 :
): ;
.; <
Select< B
(B C
xC D
=>E G
xH I
!I J
)J K
;K L
} 	
else   
{!! 	
products"" 
="" 
["" 
]"" 
;"" 
}## 	
return%% 
new%% 
CartDto%% 
(%% 
cart%% 
.%%  
Id%%  "
)%%" #
{%%$ %
Products%%& .
=%%/ 0
products%%1 9
}%%: ;
;%%; <
}&& 
public(( 


ProductDto(( 
?(( 
ToProductDto(( #
(((# $
AddedProductEntity(($ 6
cartProduct((7 B
)((B C
{)) 
var** 
product** 
=** 
_productService** %
.**% &

GetProduct**& 0
(**0 1
cartProduct**1 <
.**< =
	ProductId**= F
)**F G
;**G H
if++ 

(++ 
product++ 
!=++ 
null++ 
)++ 
{,, 	
product-- 
.-- 
Count-- 
=-- 
cartProduct-- '
.--' (
Count--( -
;--- .
}.. 	
return00 
product00 
;00 
}11 
}22 ½	
9E:\repos\e-shop\CartService\Services\Cart\ICartService.cs
	namespace 	
CartService
 
. 
Services 
. 
Cart #
;# $
public 
	interface 
ICartService 
{ 
CartDto 
Get 
( 
string 
cartId 
) 
; 
CartDto		 
GetOrCreate		 
(		 
string		 
cartId		 %
)		% &
;		& '
bool 
Delete	 
( 
string 
cartId 
) 
; 
CartDto 

AddProduct 
( 
string 
cartId $
,$ %
int& )
	productId* 3
,3 4
int5 8
count9 >
=? @
$numA B
)B C
;C D
bool 
DeleteProduct	 
( 
string 
cartId $
,$ %
int& )
	productId* 3
,3 4
int5 8
?8 9
count: ?
=@ A
nullB F
)F G
;G H
} “?
8E:\repos\e-shop\CartService\Services\Cart\CartService.cs
	namespace 	
CartService
 
. 
Services 
. 
Cart #
{		 
public

 

class

 
CartService

 
(

 
ICartMapper

 (
mapper

) /
,

/ 0
ICartRepository

1 @
cartRepository

A O
,

O P
IProductService

Q `
productService

a o
)

o p
:

q r
ICartService

s 
{ 
private 
readonly 
ICartMapper $
_mapper% ,
=- .
mapper/ 5
;5 6
private 
readonly 
ICartRepository (
_cartRepository) 8
=9 :
cartRepository; I
;I J
private 
readonly 
IProductService (
_productService) 8
=9 :
productService; I
;I J
public 
CartDto 
Get 
( 
string !
cartId" (
)( )
{ 	

CartEntity 
? 
cart 
= 
_cartRepository .
.. /
GetCart/ 6
(6 7
cartId7 =
)= >
;> ?
Guard 
. 
Against 
. 
NotFound "
(" #
cartId# )
,) *
cart+ /
)/ 0
;0 1
return 
_mapper 
. 
	ToCartDto $
($ %
cart% )
)) *
;* +
} 	
public 
CartDto 
GetOrCreate "
(" #
string# )
cartId* 0
)0 1
{ 	

CartEntity 
cart 
= !
GetOrCreateCartEntity 3
(3 4
cartId4 :
): ;
;; <
return 
_mapper 
. 
	ToCartDto $
($ %
cart% )
)) *
;* +
} 	
public   
bool   
Delete   
(   
string   !
cartId  " (
)  ( )
{!! 	
return"" 
_cartRepository"" "
.""" #

DeleteCart""# -
(""- .
cartId"". 4
)""4 5
;""5 6
}## 	
public%% 
bool%% 
DeleteProduct%% !
(%%! "
string%%" (
cartId%%) /
,%%/ 0
int%%1 4
	productId%%5 >
,%%> ?
int%%@ C
?%%C D
count%%E J
=%%K L
null%%M Q
)%%Q R
{&& 	

CartEntity'' 
?'' 
cart'' 
='' 
_cartRepository'' .
.''. /
GetCart''/ 6
(''6 7
cartId''7 =
)''= >
;''> ?
Guard)) 
.)) 
Against)) 
.)) 
NotFound)) "
())" #
cartId))# )
,))) *
cart))+ /
)))/ 0
;))0 1
AddedProductEntity++ 
?++ 
existingProduct++  /
=++0 1
cart++2 6
.++6 7
Products++7 ?
.++? @
FirstOrDefault++@ N
(++N O
p++O P
=>++Q S
p++T U
.++U V
	ProductId++V _
==++` b
	productId++c l
)++l m
;++m n
Guard-- 
.-- 
Against-- 
.-- 
NotFound-- "
(--" #
	productId--# ,
,--, -
existingProduct--. =
)--= >
;--> ?
if// 
(// 
count// 
.// 
HasValue// 
)// 
{00 
existingProduct11 
.11  
Count11  %
-=11& (
count11) .
.11. /
Value11/ 4
;114 5
}22 
if44 
(44 
!44 
count44 
.44 
HasValue44 
||44  "
existingProduct44# 2
.442 3
Count443 8
<=449 ;
$num44< =
)44= >
{55 
cart66 
.66 
Products66 
.66 
Remove66 $
(66$ %
existingProduct66% 4
)664 5
;665 6
}77 
_cartRepository99 
.99 
SaveCart99 $
(99$ %
cart99% )
)99) *
;99* +
return;; 
true;; 
;;; 
}<< 	
public>> 
CartDto>> 

AddProduct>> !
(>>! "
string>>" (
cartId>>) /
,>>/ 0
int>>1 4
	productId>>5 >
,>>> ?
int>>@ C
count>>D I
=>>J K
$num>>L M
)>>M N
{?? 	

CartEntity@@ 
cart@@ 
=@@ !
GetOrCreateCartEntity@@ 3
(@@3 4
cartId@@4 :
)@@: ;
;@@; <
varAA 
existingProductAA 
=AA  !
cartAA" &
.AA& '
ProductsAA' /
.AA/ 0
FirstOrDefaultAA0 >
(AA> ?
pAA? @
=>AAA C
pAAD E
.AAE F
	ProductIdAAF O
==AAP R
	productIdAAS \
)AA\ ]
;AA] ^
ifCC 
(CC 
existingProductCC 
!=CC  "
nullCC# '
)CC' (
{DD 
existingProductEE 
.EE  
CountEE  %
+=EE& (
countEE) .
;EE. /
}FF 
elseGG 
{HH 

ProductDtoII 
?II 
productII #
=II$ %
_productServiceII& 5
.II5 6

GetProductII6 @
(II@ A
	productIdIIA J
)IIJ K
;IIK L
GuardKK 
.KK 
AgainstKK 
.KK 
NotFoundKK &
(KK& '
	productIdKK' 0
,KK0 1
productKK2 9
)KK9 :
;KK: ;
productMM 
.MM 
CountMM 
=MM 
countMM  %
;MM% &
cartNN 
.NN 
ProductsNN 
.NN 
AddNN !
(NN! "
_mapperNN" )
.NN) *
ToAddedProductNN* 8
(NN8 9
productNN9 @
)NN@ A
)NNA B
;NNB C
}OO 
ifQQ 
(QQ 
!QQ 
_cartRepositoryQQ  
.QQ  !
SaveCartQQ! )
(QQ) *
cartQQ* .
)QQ. /
)QQ/ 0
{RR 
throwSS 
newSS 
CartCreateExceptionSS -
(SS- .
cartIdSS. 4
)SS4 5
;SS5 6
}TT 
returnVV 
_mapperVV 
.VV 
	ToCartDtoVV $
(VV$ %
cartVV% )
)VV) *
;VV* +
}WW 	
privateYY 

CartEntityYY !
GetOrCreateCartEntityYY 0
(YY0 1
stringYY1 7
cartIdYY8 >
)YY> ?
{ZZ 	

CartEntity[[ 
?[[ 
cart[[ 
=[[ 
_cartRepository[[ .
.[[. /
GetCart[[/ 6
([[6 7
cartId[[7 =
)[[= >
;[[> ?
if\\ 
(\\ 
cart\\ 
!=\\ 
null\\ 
)\\ 
{]] 
return^^ 
cart^^ 
;^^ 
}__ 
varaa 
newCartaa 
=aa 
newaa 

CartEntityaa (
(aa( )
cartIdaa) /
)aa/ 0
;aa0 1
ifbb 
(bb 
!bb 
_cartRepositorybb  
.bb  !
SaveCartbb! )
(bb) *
newCartbb* 1
)bb1 2
)bb2 3
{cc 
throwdd 
newdd 
CartCreateExceptiondd -
(dd- .
cartIddd. 4
)dd4 5
;dd5 6
}ee 
returngg 
newCartgg 
;gg 
}hh 	
}ii 
}jj ð
&E:\repos\e-shop\CartService\Program.cs
public

 
class

 
Program

 
{ 
public 

static 
async 
Task 
Main !
(! "
string" (
[( )
]) *
args+ /
)/ 0
{ 
var 
builder 
= 
WebApplication $
.$ %
CreateBuilder% 2
(2 3
args3 7
)7 8
;8 9
builder 
. 
Services 
. 
AddControllers '
(' (
)( )
;) *
builder 
. 
Services 
. !
AddDataAccessServices .
(. /
builder/ 6
.6 7
Configuration7 D
,D E
builderF M
.M N
EnvironmentN Y
)Y Z
;Z [
builder 
. 
Services 
. "
AddApplicationServices /
(/ 0
)0 1
;1 2
builder 
. 
Services 
. 
AddApiVersioning )
() *
options* 1
=>2 4
{ 	
options 
. 
ReportApiVersions %
=& '
true( ,
;, -
options 
. 
DefaultApiVersion %
=& '
new( +

ApiVersion, 6
(6 7
$num7 8
,8 9
$num: ;
); <
;< =
options 
. /
#AssumeDefaultVersionWhenUnspecified 7
=8 9
true: >
;> ?
options 
. 
ApiVersionReader $
=% &
new' *"
HeaderApiVersionReader+ A
(A B
$strB Q
)Q R
;R S
} 	
)	 

;
 
builder 
. 
Services 
.  
AddOpenApiGeneration -
(- .
). /
;/ 0
var   
app   
=   
builder   
.   
Build   
(    
)    !
;  ! "
var## 
messageBroker## 
=## 
app## 
.##  
Services##  (
.##( )
GetRequiredService##) ;
<##; <
IMessageBroker##< J
>##J K
(##K L
)##L M
;##M N
await$$ 
messageBroker$$ 
.$$ 
InitializeAsync$$ +
($$+ ,
)$$, -
.$$- .
ConfigureAwait$$. <
($$< =
false$$= B
)$$B C
;$$C D
app(( 
.(( 

AddSwagger(( 
((( 
)(( 
;(( 
app** 
.** 
UseHttpsRedirection** 
(**  
)**  !
;**! "
app,, 
.,, 
UseAuthorization,, 
(,, 
),, 
;,, 
app.. 
... 
MapControllers.. 
(.. 
).. 
;.. 
app00 
.00 
Run00 
(00 
)00 
;00 
}11 
}22 í
NE:\repos\e-shop\CartService\DataAccess\Repository\Product\ProductRepository.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !

Repository! +
.+ ,
Product, 3
{ 
public 

class 
ProductRepository "
(" #

IDbContext# -
_db. 1
)1 2
:3 4
IProductRepository5 G
{ 
public		 
bool		 
DeleteProduct		 !
(		! "
int		" %
id		& (
)		( )
{

 	
return 
_db 
. 
RunOnProducts $
($ %
(% &
products& .
). /
=>0 2
{ 
return 
products 
.  
Delete  &
(& '
id' )
)) *
;* +
} 
) 
; 
} 	
public 
ProductEntity 
? 

GetProduct (
(( )
int) ,
id- /
)/ 0
{ 	
return 
_db 
. 
RunOnProducts $
($ %
(% &
products& .
). /
=>0 2
{ 
return 
products 
.  
FindById  (
(( )
id) +
)+ ,
;, -
} 
) 
; 
} 	
public 
bool 
SaveProduct 
(  
ProductEntity  -
product. 5
)5 6
{ 	
return 
_db 
. 
RunOnProducts $
($ %
(% &
products& .
). /
=>0 2
{ 
if 
( 
products 
. 
FindById %
(% &
product& -
.- .
Id. 0
)0 1
!=2 4
null5 9
)9 :
{ 
return 
products #
.# $
Update$ *
(* +
product+ 2
)2 3
;3 4
}   
products"" 
."" 
Insert"" 
(""  
product""  '
)""' (
;""( )
return$$ 
true$$ 
;$$ 
}%% 
)%% 
;%% 
}&& 	
public(( 
bool(( 
Exists(( 
((( 
int(( 
id(( !
)((! "
{)) 	
return** 
_db** 
.** 
RunOnProducts** $
(**$ %
(**% &
products**& .
)**. /
=>**0 2
{++ 
return,, 
products,, 
.,,  
FindById,,  (
(,,( )
id,,) +
),,+ ,
!=,,- /
null,,0 4
;,,4 5
}-- 
)-- 
;-- 
}.. 	
}// 
}00 ¦
OE:\repos\e-shop\CartService\DataAccess\Repository\Product\IProductRepository.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !

Repository! +
.+ ,
Product, 3
;3 4
public 
	interface 
IProductRepository #
{ 
public 

ProductEntity 
? 

GetProduct $
($ %
int% (
id) +
)+ ,
;, -
public		 

bool		 
DeleteProduct		 
(		 
int		 !
id		" $
)		$ %
;		% &
public 

bool 
SaveProduct 
( 
ProductEntity )
product* 1
)1 2
;2 3
bool 
Exists	 
( 
int 
id 
) 
; 
} ¶
IE:\repos\e-shop\CartService\DataAccess\Repository\Cart\ICartRepository.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !

Repository! +
.+ ,
Cart, 0
{ 
public 

	interface 
ICartRepository $
{ 
public 

CartEntity 
? 
GetCart "
(" #
string# )
id* ,
), -
;- .
public		 
bool		 

DeleteCart		 
(		 
string		 %
id		& (
)		( )
;		) *
public 
bool 
SaveCart 
( 

CartEntity '
cart( ,
), -
;- .
public 
bool 
Exists 
( 
string !
id" $
)$ %
;% &
} 
} ¢
HE:\repos\e-shop\CartService\DataAccess\Repository\Cart\CartRepository.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !

Repository! +
.+ ,
Cart, 0
{ 
public 

class 
CartRepository 
(  

IDbContext  *
_db+ .
). /
:0 1
ICartRepository2 A
{ 
public 
bool 
SaveCart 
( 

CartEntity '
cart( ,
), -
{		 	
return

 
_db

 
.

 

RunOnCarts

 !
(

! "
(

" #
carts

# (
)

( )
=>

* ,
{ 
if 
( 
carts 
. 
FindById "
(" #
cart# '
.' (
Id( *
)* +
!=, .
null/ 3
)3 4
{ 
return 
carts  
.  !
Update! '
(' (
cart( ,
), -
;- .
} 
carts 
. 
Insert 
( 
cart !
)! "
;" #
return 
true 
; 
} 
) 
; 
} 	
public 
bool 

DeleteCart 
( 
string %
id& (
)( )
{ 	
return 
_db 
. 

RunOnCarts !
(! "
(" #
carts# (
)( )
=>* ,
{ 
return 
carts 
. 
Delete #
(# $
id$ &
)& '
;' (
} 
) 
; 
} 	
public 
bool 
Exists 
( 
string !
id" $
)$ %
{   	
return!! 
_db!! 
.!! 

RunOnCarts!! !
(!!! "
(!!" #
carts!!# (
)!!( )
=>!!* ,
{"" 
return## 
carts## 
.## 
FindById## %
(##% &
id##& (
)##( )
!=##* ,
null##- 1
;##1 2
}$$ 
)$$ 
;$$ 
}%% 	
public'' 

CartEntity'' 
?'' 
GetCart'' "
(''" #
string''# )
id''* ,
)'', -
{(( 	
return)) 
_db)) 
.)) 

RunOnCarts)) !
())! "
())" #
carts))# (
)))( )
=>))* ,
{** 
return++ 
carts++ 
.++ 
FindById++ %
(++% &
id++& (
)++( )
;++) *
},, 
),, 
;,, 
}-- 	
}.. 
}// ƒ
CE:\repos\e-shop\CartService\DataAccess\LiteDb\InMemoryDbInstance.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
LiteDb! '
;' (
public 
class 
InMemoryDbInstance 
(  
string  &
?& '
connectionString( 8
)8 9
:: ;
IDbInstance< G
,G H
IDisposableI T
{ 
private 
readonly 
LiteDatabase !
	_instance" +
=, -
new. 1
LiteDatabase2 >
(> ?
connectionString? O
)O P
;P Q
public		 

T		 
Execute		 
<		 
T		 
>		 
(		 
Func		 
<		 
LiteDatabase		 )
,		) *
T		+ ,
>		, -
action		. 4
)		4 5
{

 
return 
action 
( 
	_instance 
)  
;  !
} 
public 

void 
Dispose 
( 
) 
{ 
Dispose 
( 
	disposing 
: 
true 
)  
;  !
GC 

.
 
SuppressFinalize 
( 
this  
)  !
;! "
} 
private 
void 
Dispose 
( 
bool 
	disposing '
)' (
{ 
if 

( 
	disposing 
) 
{ 	
	_instance 
. 
Dispose 
( 
) 
;  
} 	
} 
~ 
InMemoryDbInstance 
( 
) 
{ 
Dispose 
( 
	disposing 
: 
false  
)  !
;! "
}   
}!! ¯
<E:\repos\e-shop\CartService\DataAccess\LiteDb\IDbInstance.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
LiteDb! '
;' (
public 
	interface 
IDbInstance 
{ 
public 

T 
Execute 
< 
T 
> 
( 
Func 
< 
LiteDatabase )
,) *
T+ ,
>, -
action. 4
)4 5
;5 6
} ¢
;E:\repos\e-shop\CartService\DataAccess\LiteDb\IDbContext.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
LiteDb! '
{ 
public 

	interface 

IDbContext 
{ 
T		 	

RunOnCarts		
 
<		 
T		 
>		 
(		 
Func		 
<		 
ILiteCollection		 ,
<		, -

CartEntity		- 7
>		7 8
,		8 9
T		: ;
>		; <
action		= C
)		C D
;		D E
T

 	
RunOnProducts


 
<

 
T

 
>

 
(

 
Func

 
<

  
ILiteCollection

  /
<

/ 0
ProductEntity

0 =
>

= >
,

> ?
T

@ A
>

A B
action

C I
)

I J
;

J K
} 
} ¯
;E:\repos\e-shop\CartService\DataAccess\LiteDb\DbInstance.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
LiteDb! '
;' (
internal 
class	 

DbInstance 
: 
IDbInstance '
{ 
private		 
readonly		 
string		 
_connectionString		 -
;		- .
public 


DbInstance 
( 
string 
? 
connectionString .
). /
{ 
if 

( 
string 
. 
IsNullOrEmpty  
(  !
connectionString! 1
)1 2
)2 3
{ 	
throw 
new $
DbConfigurationException .
(. /
)/ 0
;0 1
} 	
_connectionString 
= 
connectionString ,
;, -
} 
public 

T 
Execute 
< 
T 
> 
( 
Func 
< 
LiteDatabase )
,) *
T+ ,
>, -
action. 4
)4 5
{ 
using 
var 
db 
= 
new 
LiteDatabase '
(' (
_connectionString( 9
)9 :
;: ;
return 
action 
( 
db 
) 
; 
} 
} Œ
:E:\repos\e-shop\CartService\DataAccess\LiteDb\DbContext.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
LiteDb! '
;' (
public 
class 
	DbContext 
( 
IDbInstance "
db# %
)% &
:' (

IDbContext) 3
{ 
public		 

T		 

RunOnCarts		 
<		 
T		 
>		 
(		 
Func		 
<		  
ILiteCollection		  /
<		/ 0

CartEntity		0 :
>		: ;
,		; <
T		= >
>		> ?
action		@ F
)		F G
{

 
return 
db 
. 
Execute 
( 
x 
=> 
action %
(% &
x& '
.' (
GetCollection( 5
<5 6

CartEntity6 @
>@ A
(A B
$strB R
)R S
)S T
)T U
;U V
} 
public 

T 
RunOnProducts 
< 
T 
> 
( 
Func "
<" #
ILiteCollection# 2
<2 3
ProductEntity3 @
>@ A
,A B
TC D
>D E
actionF L
)L M
{ 
return 
db 
. 
Execute 
( 
x 
=> 
action %
(% &
x& '
.' (
GetCollection( 5
<5 6
ProductEntity6 C
>C D
(D E
$strE \
)\ ]
)] ^
)^ _
;_ `
} 
} ‹
=E:\repos\e-shop\CartService\DataAccess\DependencyInjection.cs
	namespace 	
CartService
 
. 

DataAccess  
{		 
public

 

static

 
class

 
DependencyInjection

 +
{ 
public 
static 
IServiceCollection (!
AddDataAccessServices) >
(> ?
this? C
IServiceCollectionD V
servicesW _
,_ `
IConfigurationa o
configp v
,v w 
IWebHostEnvironment	x ‹
env
Œ 
)
 
{ 	
var 
connectionString  
=! "
config# )
.) *
GetConnectionString* =
(= >
$str> F
)F G
;G H
if 
( 
env 
. 
IsEnvironment !
(! "
$str" (
)( )
)) *
{ 
services 
. 
AddSingleton %
<% &
IDbInstance& 1
>1 2
(2 3
new3 6
InMemoryDbInstance7 I
(I J
connectionStringJ Z
)Z [
)[ \
;\ ]
} 
else 
{ 
services 
. 
AddSingleton %
<% &
IDbInstance& 1
>1 2
(2 3
new3 6

DbInstance7 A
(A B
connectionStringB R
)R S
)S T
;T U
} 
services 
. 
AddSingleton !
<! "

IDbContext" ,
,, -
	DbContext. 7
>7 8
(8 9
)9 :
;: ;
services 
. 
AddSingleton !
<! "
ICartRepository" 1
,1 2
CartRepository3 A
>A B
(B C
)C D
;D E
services 
. 
AddSingleton !
<! "
IProductRepository" 4
,4 5
ProductRepository6 G
>G H
(H I
)I J
;J K
services 
. 
AddMessageBroker %
(% &
config& ,
), -
;- .
return 
services 
; 
}   	
}!! 
}"" Ã
GE:\repos\e-shop\CartService\DataAccess\Common\Entities\ProductEntity.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
Common! '
.' (
Entities( 0
;0 1
public 
record 
ProductEntity 
( 
int 
Id  "
)" #
{ 
public 

required 
string 
Name 
{  !
get" %
;% &
set' *
;* +
}, -
public		 

required		 
decimal		 
Price		 !
{		" #
get		$ '
;		' (
set		) ,
;		, -
}		. /
public 

string 
? 
Description 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 

string 
? 
Image 
{ 
get 
; 
set  #
;# $
}% &
} ç
TE:\repos\e-shop\CartService\DataAccess\Common\Exceptions\DbConfigurationException.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
Common! '
.' (

Exceptions( 2
{ 
public 

class $
DbConfigurationException )
:* +
	Exception, 5
{ 
public $
DbConfigurationException '
(' (
)( )
:* +
base, 0
(0 1
$str1 r
)r s
{ 	
} 	
}		 
}

 ¢
DE:\repos\e-shop\CartService\DataAccess\Common\Entities\CartEntity.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
Common! '
.' (
Entities( 0
;0 1
public 
record 

CartEntity 
( 
string 
Id  "
)" #
{ 
public 

IList 
< 
AddedProductEntity #
># $
Products% -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
== >
[? @
]@ A
;A B
} œ
LE:\repos\e-shop\CartService\DataAccess\Common\Entities\AddedProductEntity.cs
	namespace 	
CartService
 
. 

DataAccess  
.  !
Common! '
.' (
Entities( 0
{ 
public 

record 
AddedProductEntity $
{ 
public 
int 
	ProductId 
{ 
get "
;" #
init$ (
;( )
}* +
public 
int 
Count 
{ 
get 
; 
set  #
;# $
}% &
} 
} 