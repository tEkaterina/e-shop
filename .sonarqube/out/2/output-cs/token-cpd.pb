Æ
hE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\GetProduct\GetProductQuery.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6

GetProduct6 @
;@ A
public 
record 
GetProductQuery 
( 
int !
Id" $
)$ %
:& '
IRequest( 0
<0 1

ProductDto1 ;
>; <
;< =ı
jE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\GetProduct\GetProductHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6

GetProduct6 @
;@ A
public 
class 
GetProductHandler 
( !
IApplicationDbContext 4
	dbContext5 >
)> ?
:@ A
IRequestHandlerB Q
<Q R
GetProductQueryR a
,a b

ProductDtoc m
>m n
{ 
private		 
readonly		 !
IApplicationDbContext		 *

_dbContext		+ 5
=		6 7
	dbContext		8 A
;		A B
public 

async 
Task 
< 

ProductDto  
>  !
Handle" (
(( )
GetProductQuery) 8
request9 @
,@ A
CancellationTokenB S
cancellationTokenT e
)e f
{ 
var 
product 
= 
await 

_dbContext &
.& '
Products' /
./ 0
	FindAsync0 9
(9 :
[: ;
request; B
.B C
IdC E
]E F
,F G
cancellationTokenH Y
)Y Z
.Z [
ConfigureAwait[ i
(i j
falsej o
)o p
;p q
Guard 
. 
Against 
. 
NotFound 
( 
request &
.& '
Id' )
,) *
product+ 2
)2 3
;3 4
return 
product 
. 
ToProductDto #
(# $
)$ %
;% &
} 
} √
nE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\GetProducts\GetProductsValidator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6
GetProducts6 A
;A B
public 
class  
GetProductsValidator !
:" #
AbstractValidator$ 5
<5 6
GetProductsQuery6 F
>F G
{ 
public 
 
GetProductsValidator 
(  
)  !
{ 
RuleFor		 
(		 
x		 
=>		 
x		 
.		 

CategoryId		 !
)		! "
.		" #
NotEmpty		# +
(		+ ,
)		, -
.		- .
WithMessage		. 9
(		9 :
$str		: b
)		b c
;		c d
RuleFor 
( 
x 
=> 
x 
. 
	PageIndex  
)  !
.! "
GreaterThan" -
(- .
$num. /
)/ 0
.0 1
WithMessage1 <
(< =
$str= a
)a b
;b c
RuleFor 
( 
x 
=> 
x 
. 
PageSize 
)  
.  !
GreaterThan! ,
(, -
$num- .
). /
./ 0
WithMessage0 ;
(; <
$str< _
)_ `
;` a
} 
} Ÿ
jE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\GetProducts\GetProductsQuery.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6
GetProducts6 A
;A B
public 
record 
GetProductsQuery 
( 
int "
?" #

CategoryId$ .
=/ 0
null1 5
,5 6
int7 :
	PageIndex; D
=E F
$numG H
,H I
intJ M
PageSizeN V
=W X
$numY [
)[ \
:] ^
IRequest_ g
<g h
PaginatedListh u
<u v

ProductDto	v Ä
>
Ä Å
>
Å Ç
;
Ç É¿
lE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\GetProducts\GetProductsHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6
GetProducts6 A
{ 
public 

class 
GetProductsHandler #
(# $!
IApplicationDbContext$ 9
	dbContext: C
)C D
:E F
IRequestHandlerG V
<V W
GetProductsQueryW g
,g h
PaginatedListi v
<v w

ProductDto	w Å
>
Å Ç
>
Ç É
{		 
private

 
readonly

 !
IApplicationDbContext

 .

_dbContext

/ 9
=

: ;
	dbContext

< E
;

E F
public 
Task 
< 
PaginatedList !
<! "

ProductDto" ,
>, -
>- .
Handle/ 5
(5 6
GetProductsQuery6 F
requestG N
,N O
CancellationTokenP a
cancellationTokenb s
)s t
{ 	

IQueryable 
< 
Product 
> 
products  (
=) *

_dbContext+ 5
.5 6
Products6 >
;> ?
if 
( 
request 
. 

CategoryId "
." #
HasValue# +
)+ ,
{ 
products 
= 
products #
.# $
Where$ )
() *
x* +
=>, .
x/ 0
.0 1

CategoryId1 ;
==< >
request? F
.F G

CategoryIdG Q
)Q R
;R S
} 
return 
PaginatedList  
<  !

ProductDto! +
>+ ,
., -
CreateAsync- 8
(8 9
products9 A
.A B
SelectB H
(H I
xI J
=>K M
xN O
.O P
ToProductDtoP \
(\ ]
)] ^
)^ _
,_ `
requesta h
.h i
	PageIndexi r
,r s
requestt {
.{ |
PageSize	| Ñ
,
Ñ Ö
cancellationToken
Ü ó
)
ó ò
;
ò ô
} 	
} 
} ƒ
mE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\Common\Mappers\ProductDtoMapper.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6
Common6 <
.< =
Mappers= D
{ 
internal 
static 
class 
ProductDtoMapper *
{ 
internal 
static 
Product 
	ToProduct  )
() *
this* .

ProductDto/ 9

productDto: D
)D E
{ 	
return		 
new		 
Product		 
{

 
Id 
= 

productDto 
.  
Id  "
," #
Name 
= 

productDto !
.! "
Name" &
,& '
Amount 
= 

productDto #
.# $
Amount$ *
,* +

CategoryId 
= 

productDto '
.' (

CategoryId( 2
,2 3
Description 
= 

productDto (
.( )
Description) 4
,4 5
Image 
= 

productDto "
." #
Image# (
,( )
Price 
= 

productDto "
." #
Price# (
,( )
} 
; 
} 	
internal 
static 

ProductDto "
ToProductDto# /
(/ 0
this0 4
Product5 <
product= D
)D E
{ 	
return 
new 

ProductDto !
(! "
product 
. 
Id 
, 
product 
. 
Name 
, 
product 
. 
Price 
, 
product 
. 
Amount 
, 
product 
. 

CategoryId "
," #
product 
. 
Description #
,# $
product 
. 
Image 
) 
; 
}   	
}!! 
}"" ú
cE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Queries\Common\Dto\ProductDto.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Queries. 5
.5 6
Common6 <
.< =
Dto= @
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
,0 1
decimal2 9
Price: ?
,? @
intA D
AmountE K
,K L
intM P

CategoryIdQ [
,[ \
string 
? 
Description 
= 
null "
," #
string$ *
?* +
Image, 1
=2 3
null4 8
)8 9
;9 :
} Ë
sE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\UpdateProduct\UpdateProductValidator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
UpdateProduct7 D
{ 
public 

class "
UpdateProductValidator '
:( )
AbstractValidator* ;
<; < 
UpdateProductCommand< P
>P Q
{		 
private

 
readonly

 !
IApplicationDbContext

 .

_dbContext

/ 9
;

9 :
public "
UpdateProductValidator %
(% &!
IApplicationDbContext& ;
	dbContext< E
)E F
{ 	

_dbContext 
= 
	dbContext "
;" #
RuleFor 
( 
x 
=> 
x 
. 
Name 
)  
.  !
NotEmpty! )
() *
)* +
.+ ,
MaximumLength, 9
(9 :
$num: <
)< =
;= >
RuleFor 
( 
x 
=> 
x 
. 
Price  
)  !
.! " 
GreaterThanOrEqualTo" 6
(6 7
$num7 8
)8 9
;9 :
RuleFor 
( 
x 
=> 
x 
. 
Amount !
)! "
." # 
GreaterThanOrEqualTo# 7
(7 8
$num8 9
)9 :
;: ;
RuleFor 
( 
x 
=> 
x 
. 
Description &
)& '
.' (
	ValidHtml( 1
(1 2
)2 3
;3 4
RuleFor 
( 
x 
=> 
x 
. 
Image  
)  !
.! "
ValidUrl" *
(* +
)+ ,
;, -
RuleFor 
( 
x 
=> 
x 
. 

CategoryId %
)% &
.& '
	MustAsync' 0
(0 1
IsValidCategory1 @
)@ A
.A B
WithMessageB M
(M N
$strN d
)d e
;e f
} 	
private 
async 
Task 
< 
bool 
>  
IsValidCategory! 0
(0 1
int1 4

categoryId5 ?
,? @
CancellationTokenA R
cancellationTokenS d
)d e
{ 	
var 
category 
= 
await  

_dbContext! +
.+ ,

Categories, 6
.6 7
	FindAsync7 @
(@ A
[A B

categoryIdB L
]L M
,M N
cancellationTokenO `
)` a
.a b
ConfigureAwaitb p
(p q
falseq v
)v w
;w x
return 
category 
!= 
null #
;# $
} 	
} 
} Á
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\UpdateProduct\UpdateProductHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
UpdateProduct7 D
;D E
public 
class  
UpdateProductHandler !
(! "!
IApplicationDbContext" 7
	dbContext8 A
,A B(
IApplicationMessagePublisherC _
	publisher` i
)i j
:k l
IRequestHandlerm |
<| }!
UpdateProductCommand	} ë
>
ë í
{ 
private 
readonly !
IApplicationDbContext *

_dbContext+ 5
=6 7
	dbContext8 A
;A B
public

 

async

 
Task

 
Handle

 
(

  
UpdateProductCommand

 1
request

2 9
,

9 :
CancellationToken

; L
cancellationToken

M ^
)

^ _
{ 
var 
product 
= 
await 

_dbContext &
.& '
Products' /
./ 0
	FindAsync0 9
(9 :
[: ;
request; B
.B C
IdC E
]E F
,F G
cancellationTokenH Y
)Y Z
.Z [
ConfigureAwait[ i
(i j
falsej o
)o p
;p q
Guard 
. 
Against 
. 
NotFound 
( 
request &
.& '
Id' )
,) *
product+ 2
)2 3
;3 4
product 
. 
Amount 
= 
request  
.  !
Amount! '
;' (
product 
. 
Description 
= 
request %
.% &
Description& 1
;1 2
product 
. 
Price 
= 
request 
.  
Price  %
;% &
product 
. 

CategoryId 
= 
request $
.$ %

CategoryId% /
;/ 0
product 
. 
Image 
= 
request 
.  
Image  %
;% &
product 
. 
Name 
= 
request 
. 
Name #
;# $
await 

_dbContext 
. 
SaveChangesAsync )
() *
cancellationToken* ;
); <
.< =
ConfigureAwait= K
(K L
falseL Q
)Q R
;R S
await 
	publisher 
. %
PublishProductUpdateAsync 1
(1 2
new2 5
ProductChangeEvent6 H
(H I
requestI P
.P Q
IdQ S
,S T
newU X 
ProductChangeDetailsY m
(m n
)n o
{ 	
Description 
= 
request !
.! "
Description" -
,- .
Image 
= 
request 
. 
Image !
,! "
Name 
= 
request 
. 
Name 
,  
Price 
= 
request 
. 
Price !
} 	
)	 

)
 
. 
ConfigureAwait 
( 
false  
)  !
;! "
}   
}!! ≈
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\UpdateProduct\UpdateProductCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
UpdateProduct7 D
;D E
public 
record  
UpdateProductCommand "
(" #
int 
Id 

,
 
string 

Name 
, 
int 

CategoryId 
, 
decimal 
Price 
, 
int 
Amount 
) 
: 
IRequest 
{		 
public

 

string

 
?

 
Description

 
{

  
get

! $
;

$ %
init

& *
;

* +
}

, -
public 

string 
? 
Image 
{ 
get 
; 
init  $
;$ %
}& '
} ‰
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\DeleteProduct\DeleteProductHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
DeleteProduct7 D
{ 
public 

class  
DeleteProductHandler %
(% &!
IApplicationDbContext& ;
	dbContext< E
)E F
:G H
IRequestHandlerI X
<X Y 
DeleteProductCommandY m
>m n
{ 
private 
readonly !
IApplicationDbContext .

_dbContext/ 9
=: ;
	dbContext< E
;E F
public		 
async		 
Task		 
Handle		  
(		  ! 
DeleteProductCommand		! 5
request		6 =
,		= >
CancellationToken		? P
cancellationToken		Q b
)		b c
{

 	
var 
product 
= 
await 

_dbContext  *
.* +
Products+ 3
.3 4
	FindAsync4 =
(= >
[> ?
request? F
.F G
IdG I
]I J
,J K
cancellationTokenL ]
)] ^
.^ _
ConfigureAwait_ m
(m n
falsen s
)s t
;t u
Guard 
. 
Against 
. 
NotFound "
(" #
request# *
.* +
Id+ -
,- .
product/ 6
)6 7
;7 8

_dbContext 
. 
Products 
.  
Remove  &
(& '
product' .
). /
;/ 0
await 

_dbContext 
. 
SaveChangesAsync -
(- .
cancellationToken. ?
)? @
.@ A
ConfigureAwaitA O
(O P
falseP U
)U V
;V W
} 	
} 
} ä
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\DeleteProduct\DeleteProductCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
DeleteProduct7 D
;D E
public 
record  
DeleteProductCommand "
(" #
int# &
Id' )
)) *
:+ ,
IRequest- 5
;5 6Ä
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\CreateProduct\CreateProductHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
CreateProduct7 D
{ 
public 

class  
CreateProductHandler %
(% &!
IApplicationDbContext& ;
	dbContext< E
)E F
:G H
IRequestHandlerI X
<X Y 
CreateProductCommandY m
,m n
into r
>r s
{ 
private 
readonly !
IApplicationDbContext .

_dbContext/ 9
=: ;
	dbContext< E
;E F
public		 
async		 
Task		 
<		 
int		 
>		 
Handle		 %
(		% & 
CreateProductCommand		& :
request		; B
,		B C
CancellationToken		D U
cancellationToken		V g
)		g h
{

 	
var 
product 
= 
new 
Product %
{ 
Name 
= 
request 
. 
Name #
,# $
Image 
= 
request 
.  
Image  %
,% &
Amount 
= 
request  
.  !
Amount! '
,' (

CategoryId 
= 
request $
.$ %

CategoryId% /
,/ 0
Description 
= 
request %
.% &
Description& 1
,1 2
Price 
= 
request 
.  
Price  %
,% &
} 
; 

_dbContext 
. 
Products 
.  
Add  #
(# $
product$ +
)+ ,
;, -
await 

_dbContext 
. 
SaveChangesAsync -
(- .
cancellationToken. ?
)? @
.@ A
ConfigureAwaitA O
(O P
falseP U
)U V
;V W
return 
product 
. 
Id 
; 
} 	
} 
} ◊
sE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\CreateProduct\CreateProductValidator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
CreateProduct7 D
;D E
public 
class "
CreateProductValidator #
:$ %
AbstractValidator& 7
<7 8 
CreateProductCommand8 L
>L M
{		 
private

 
readonly

 !
IApplicationDbContext

 *

_dbContext

+ 5
;

5 6
public 
"
CreateProductValidator !
(! "!
IApplicationDbContext" 7
	dbContext8 A
)A B
{ 

_dbContext 
= 
	dbContext 
; 
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
NotEmpty %
(% &
)& '
.' (
MaximumLength( 5
(5 6
$num6 8
)8 9
;9 :
RuleFor 
( 
x 
=> 
x 
. 
Price 
) 
.  
GreaterThanOrEqualTo 2
(2 3
$num3 4
)4 5
;5 6
RuleFor 
( 
x 
=> 
x 
. 
Amount 
) 
.  
GreaterThanOrEqualTo 3
(3 4
$num4 5
)5 6
;6 7
RuleFor 
( 
x 
=> 
x 
. 
Description "
)" #
.# $
	ValidHtml$ -
(- .
). /
;/ 0
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
ValidUrl &
(& '
)' (
;( )
RuleFor 
( 
x 
=> 
x 
. 

CategoryId !
)! "
." #
	MustAsync# ,
(, -
IsValidCategory- <
)< =
.= >
WithMessage> I
(I J
$strJ `
)` a
;a b
} 
private 
async 
Task 
< 
bool 
> 
IsValidCategory ,
(, -
int- 0

categoryId1 ;
,; <
CancellationToken= N
cancellationTokenO `
)` a
{ 
var 
category 
= 
await 

_dbContext '
.' (

Categories( 2
.2 3
	FindAsync3 <
(< =
[= >

categoryId> H
]H I
,I J
cancellationTokenK \
)\ ]
.] ^
ConfigureAwait^ l
(l m
falsem r
)r s
;s t
return 
category 
!= 
null 
;  
} 
} ƒ
qE:\repos\e-shop\CatalogService\CatalogService.Application\Products\Commands\CreateProduct\CreateProductCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Products% -
.- .
Commands. 6
.6 7
CreateProduct7 D
;D E
public 
record  
CreateProductCommand "
(" #
string 

Name 
, 
int 

CategoryId 
, 
decimal 
Price 
, 
int 
Amount 
) 
: 
IRequest 
< 
int 
> 
{ 
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
 
init

  $
;

$ %
}

& '
} K
IE:\repos\e-shop\CatalogService\CatalogService.Application\GlobalUsings.cs‹	
PE:\repos\e-shop\CatalogService\CatalogService.Application\DependencyInjection.cs
	namespace 	
	Microsoft
 
. 

Extensions 
. 
DependencyInjection 2
;2 3
public 
static 
class 
DependencyInjection '
{ 
public		 

static		 
IServiceCollection		 $
AddAppServices		% 3
(		3 4
this		4 8
IServiceCollection		9 K
services		L T
)		T U
{

 
services 
. %
AddValidatorsFromAssembly *
(* +
Assembly+ 3
.3 4 
GetExecutingAssembly4 H
(H I
)I J
)J K
;K L
services 
. 

AddMediatR 
( 
cfg 
=>  "
{ 	
cfg 
. (
RegisterServicesFromAssembly ,
(, -
Assembly- 5
.5 6 
GetExecutingAssembly6 J
(J K
)K L
)L M
;M N
} 	
)	 

;
 
return 
services 
; 
} 
} á
hE:\repos\e-shop\CatalogService\CatalogService.Application\Common\PipelineBehaviors\ValidationBehavior.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,
PipelineBehaviors, =
{ 
public 

class 
ValidationBehavior #
<# $
TRequest$ ,
,, -
	TResponse. 7
>7 8
(8 9
IEnumerable9 D
<D E

IValidatorE O
<O P
TRequestP X
>X Y
>Y Z

validators[ e
)e f
:g h
IPipelineBehaviori z
<z {
TRequest	{ É
,
É Ñ
	TResponse
Ö é
>
é è
where	 
TRequest 
: 
notnull !
{ 
private 
readonly 
IEnumerable $
<$ %

IValidator% /
</ 0
TRequest0 8
>8 9
>9 :
_validators; F
=G H

validatorsI S
;S T
public

 
async

 
Task

 
<

 
	TResponse

 #
>

# $
Handle

% +
(

+ ,
TRequest

, 4
request

5 <
,

< ="
RequestHandlerDelegate

> T
<

T U
	TResponse

U ^
>

^ _
next

` d
,

d e
CancellationToken

f w
cancellationToken	

x â
)


â ä
{ 	
if 
( 
! 
_validators 
. 
Any  
(  !
)! "
)" #
{ 
return 
await 
next !
(! "
)" #
.# $
ConfigureAwait$ 2
(2 3
false3 8
)8 9
;9 :
} 
var 
results 
= 
await 
Task  $
.$ %
WhenAll% ,
(, -
_validators- 8
.8 9
Select9 ?
(? @
x@ A
=>B D
xE F
.F G
ValidateAsyncG T
(T U
requestU \
,\ ]
cancellationToken^ o
)o p
)p q
)q r
.r s
ConfigureAwait	s Å
(
Å Ç
false
Ç á
)
á à
;
à â
var 
errors 
= 
results  
.  !
Where! &
(& '
x' (
=>) +
!, -
x- .
.. /
IsValid/ 6
)6 7
.7 8

SelectMany8 B
(B C
xC D
=>E G
xH I
.I J
ErrorsJ P
)P Q
.Q R
ToArrayR Y
(Y Z
)Z [
;[ \
if 
( 
errors 
. 
Length 
!=  
$num! "
)" #
{ 
throw 
new 
ValidationException -
(- .
errors. 4
)4 5
;5 6
} 
return 
await 
next 
( 
) 
.  
ConfigureAwait  .
(. /
false/ 4
)4 5
;5 6
} 	
} 
} ø
XE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Models\PaginatedList.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,
Models, 2
;2 3
public 
class 
PaginatedList 
< 
T 
> 
{ 
public		 

IReadOnlyCollection		 
<		 
T		  
>		  !
Items		" '
{		( )
get		* -
;		- .
}		/ 0
public

 

int

 
	PageIndex

 
{

 
get

 
;

 
}

  !
public 

int 
PageSize 
{ 
get 
; 
}  
public 

int 

TotalPages 
{ 
get 
;  
}! "
public 

int 

TotalCount 
{ 
get 
;  
}! "
private 
PaginatedList 
( 
IReadOnlyCollection -
<- .
T. /
>/ 0
items1 6
,6 7
int8 ;
index< A
,A B
intC F

totalPagesG Q
,Q R
intS V

totalCountW a
,a b
intc f
pageSizeg o
)o p
{ 
Items 
= 
items 
; 
	PageIndex 
= 
index 
; 
PageSize 
= 
pageSize 
; 

TotalPages 
= 

totalPages 
;  

TotalCount 
= 

totalCount 
;  
} 
public 

static 
async 
Task 
< 
PaginatedList *
<* +
T+ ,
>, -
>- .
CreateAsync/ :
(: ;

IQueryable; E
<E F
TF G
>G H
sourceI O
,O P
intQ T
	pageIndexU ^
,^ _
int` c
pageSized l
,l m
CancellationTokenn 
cancellationToken
Ä ë
)
ë í
{ 
var 
count 
= 
await 
source  
.  !

CountAsync! +
(+ ,
cancellationToken, =
)= >
.> ?
ConfigureAwait? M
(M N
falseN S
)S T
;T U
var 

totalPages 
= 
( 
int 
)  
Math  $
.$ %
Ceiling% ,
(, -
count- 2
/3 4
(5 6
double7 =
)> ?
	pageIndex? H
)H I
;I J
var 
items 
= 
await 
source  
.  !
Skip! %
(% &
(& '
	pageIndex' 0
-1 2
$num3 4
)4 5
*6 7
pageSize8 @
)@ A
.A B
TakeB F
(F G
pageSizeG O
)O P
.P Q
ToListAsyncQ \
(\ ]
cancellationToken] n
)n o
.o p
ConfigureAwaitp ~
(~ 
false	 Ñ
)
Ñ Ö
;
Ö Ü
return 
new 
PaginatedList  
<  !
T! "
>" #
(# $
items$ )
,) *
	pageIndex+ 4
,4 5

totalPages6 @
,@ A
countB G
,G H
pageSizeI Q
)Q R
;R S
}   
}!! ú
YE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Models\HypermediaLink.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,
Models, 2
;2 3
public 
record 
class 
HypermediaLink "
(" #
string# )
Ref* -
,- .
string/ 5
Href6 :
,: ;
string< B
MethodC I
)I J
;J K†
_E:\repos\e-shop\CatalogService\CatalogService.Application\Common\Interfaces\IHyperlinkObject.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Interfaces, 6
;6 7
public 
	interface 
IHyperlinkObject !
{ 
IReadOnlyCollection 
< 
HypermediaLink &
>& '
Links( -
{. /
get0 3
;3 4
}5 6
} ß
kE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Interfaces\IApplicationMessagePublisher.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Interfaces, 6
;6 7
public 
	interface (
IApplicationMessagePublisher -
{ 
Task %
PublishProductUpdateAsync	 "
(" #
ProductChangeEvent# 5
message6 =
)= >
;> ?
} ˇ
dE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Interfaces\IApplicationDbContext.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Interfaces, 6
;6 7
public 
	interface !
IApplicationDbContext &
{ 
DbSet 	
<	 

Category
 
> 

Categories 
{  
get! $
;$ %
}& '
DbSet		 	
<			 

Product		
 
>		 
Products		 
{		 
get		 !
;		! "
}		# $
Task 
< 	
int	 
> 
SaveChangesAsync 
( 
CancellationToken 0
cancellationToken1 B
)B C
;C D
} ≥
mE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Extensions\Validators\UrlFluentValidation.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Extensions, 6
.6 7

Validators7 A
{ 
internal 
static 
class 
UrlFluentValidation -
{ 
internal 
static 
IRuleBuilderOptions +
<+ ,
T, -
,- .
string/ 5
?5 6
>6 7
ValidUrl8 @
<@ A
TA B
>B C
(C D
thisD H
IRuleBuilderI U
<U V
TV W
,W X
stringY _
?_ `
>` a
ruleBuilderb m
)m n
{ 	
return		 
ruleBuilder		 
.		 
Must		 #
(		# $

IsValidUrl		$ .
)		. /
.		/ 0
WithMessage		0 ;
(		; <
$str		< Q
)		Q R
;		R S
}

 	
private 
static 
bool 

IsValidUrl &
(& '
string' -
?- .
url/ 2
)2 3
{ 	
if 
( 
string 
. 
IsNullOrEmpty $
($ %
url% (
)( )
)) *
return 
true 
; 
return 
! 
( 
! 
Uri 
. 
	TryCreate #
(# $
url$ '
,' (
UriKind) 0
.0 1
Absolute1 9
,9 :
out; >
Uri? B
?B C
validatedUriD P
)P Q
|| 
validatedUri 
.  
Scheme  &
!=' )
Uri* -
.- .
UriSchemeHttp. ;
&&< >
validatedUri? K
.K L
SchemeL R
!=S U
UriV Y
.Y Z
UriSchemeHttpsZ h
)h i
;i j
} 	
} 
} ‡
nE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Extensions\Validators\HtmlFluentValidation.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Extensions, 6
.6 7

Validators7 A
{ 
internal 
static 
class  
HtmlFluentValidation .
{ 
internal		 
static		 
IRuleBuilderOptions		 +
<		+ ,
T		, -
,		- .
string		/ 5
?		5 6
>		6 7
	ValidHtml		8 A
<		A B
T		B C
>		C D
(		D E
this		E I
IRuleBuilder		J V
<		V W
T		W X
,		X Y
string		Z `
?		` a
>		a b
ruleBuilder		c n
)		n o
{

 	
return 
ruleBuilder 
. 
Must #
(# $
IsValidHtml$ /
)/ 0
.0 1
WithMessage1 <
(< =
$str= T
)T U
;U V
} 	
private 
static 
bool 
IsValidHtml '
(' (
string( .
?. /
htmlContent0 ;
); <
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
htmlContent* 5
)5 6
)6 7
return 
true 
; 
var 
	sanitizer 
= 
new 
HtmlSanitizer  -
(- .
). /
;/ 0
var 
	sanitized 
= 
	sanitizer %
.% &
Sanitize& .
(. /
htmlContent/ :
): ;
;; <
return 
	sanitized 
== 
htmlContent  +
;+ ,
} 	
} 
} º
fE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Extensions\HypermediaLinkGenerator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Extensions, 6
;6 7
public 
static 
class #
HypermediaLinkGenerator +
{ 
public 

static 
IReadOnlyCollection %
<% &
HypermediaLink& 4
>4 5
GenerateAll6 A
(A B
string		 
id		 
,		 
string

 
location

 
) 
{ 
return 
[ 
new 
HypermediaLink 
( 
$str %
,% &
$"' )
$str) *
{* +
location+ 3
}3 4
$str4 5
{5 6
id6 8
}8 9
"9 :
,: ;
$str< A
)A B
,B C
new 
HypermediaLink 
( 
$str '
,' (
$") +
$str+ ,
{, -
location- 5
}5 6
$str6 7
{7 8
id8 :
}: ;
"; <
,< =
$str> C
)C D
,D E
new 
HypermediaLink 
( 
$str '
,' (
$") +
$str+ ,
{, -
location- 5
}5 6
$str6 7
{7 8
id8 :
}: ;
"; <
,< =
$str> F
)F G
] 	
;	 

} 
} À
bE:\repos\e-shop\CatalogService\CatalogService.Application\Common\Exceptions\ValidationException.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %
Common% +
.+ ,

Exceptions, 6
;6 7
public 
class 
ValidationException  
(  !
)! "
:# $
	Exception% .
(. /
$str/ ]
)] ^
{ 
public 

IDictionary 
< 
string 
, 
string %
[% &
]& '
>' (
Errors) /
{0 1
get2 5
;5 6
}7 8
=9 :
new; >

Dictionary? I
<I J
stringJ P
,P Q
stringR X
[X Y
]Y Z
>Z [
([ \
)\ ]
;] ^
public		 

ValidationException		 
(		 
IEnumerable		 *
<		* +
ValidationFailure		+ <
>		< =
errors		> D
)		D E
:		F G
this		H L
(		L M
)		M N
{

 
Errors 
= 
errors 
. 
GroupBy 
( 
e 
=> 
e 
. 
PropertyName (
,( )
e* +
=>, .
e/ 0
.0 1
ErrorMessage1 =
)= >
. 
ToDictionary 
( 

errorGroup $
=>% '

errorGroup( 2
.2 3
Key3 6
,6 7

errorGroup8 B
=>C E

errorGroupF P
.P Q
ToArrayQ X
(X Y
)Y Z
)Z [
;[ \
} 
} ∑
lE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\GetCategory\GetCategoryQuery.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
GetCategory8 C
;C D
public 
record 
GetCategoryQuery 
( 
int "
Id# %
)% &
:' (
IRequest) 1
<1 2
CategoryDto2 =
>= >
;> ?ˇ
nE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\GetCategory\GetCategoryHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
GetCategory8 C
;C D
public 
class 
GetCategoryHandler 
(  !
IApplicationDbContext  5
	dbContext6 ?
)? @
:A B
IRequestHandlerC R
<R S
GetCategoryQueryS c
,c d
CategoryDtoe p
>p q
{ 
private		 
readonly		 !
IApplicationDbContext		 *

_dbContext		+ 5
=		6 7
	dbContext		8 A
;		A B
public 

async 
Task 
< 
CategoryDto !
>! "
Handle# )
() *
GetCategoryQuery* :
request; B
,B C
CancellationTokenD U
cancellationTokenV g
)g h
{ 
var 
category 
= 
await 

_dbContext '
.' (

Categories( 2
.2 3
	FindAsync3 <
(< =
[= >
request> E
.E F
IdF H
]H I
,I J
cancellationTokenK \
)\ ]
.] ^
ConfigureAwait^ l
(l m
falsem r
)r s
;s t
Guard 
. 
Against 
. 
NotFound 
( 
request &
.& '
Id' )
,) *
category+ 3
)3 4
;4 5
return 
category 
. 
ToDto 
( 
) 
;  
} 
} ø
pE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\GetCategories\GetCategoriesQuery.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
GetCategories8 E
;E F
public 
record 
GetCategoriesQuery  
:! "
IRequest# +
<+ ,
IReadOnlyCollection, ?
<? @
CategoryDto@ K
>K L
>L M
;M N∆
rE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\GetCategories\GetCategoriesHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
GetCategories8 E
;E F
public

 
class

  
GetCategoriesHandler

 !
(

! "!
IApplicationDbContext

" 7
	dbContext

8 A
)

A B
:

C D
IRequestHandler

E T
<

T U
GetCategoriesQuery

U g
,

g h
IReadOnlyCollection

i |
<

| }
CategoryDto	

} à
>


à â
>


â ä
{ 
private 
readonly !
IApplicationDbContext *

_dbContext+ 5
=6 7
	dbContext8 A
;A B
public 

async 
Task 
< 
IReadOnlyCollection )
<) *
CategoryDto* 5
>5 6
>6 7
Handle8 >
(> ?
GetCategoriesQuery? Q
requestR Y
,Y Z
CancellationToken[ l
cancellationTokenm ~
)~ 
{ 
var 

categories 
= 
await 

_dbContext )
.) *

Categories* 4
.4 5
Select5 ;
(; <
x< =
=>> @
xA B
.B C
ToDtoC H
(H I
)I J
)J K
.K L
ToArrayAsyncL X
(X Y
cancellationTokenY j
)j k
.k l
ConfigureAwaitl z
(z {
false	{ Ä
)
Ä Å
;
Å Ç
return 

categories 
; 
} 
} ¥
pE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\Common\Mappers\CategoryDtoMapper.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
Common8 >
.> ?
Mappers? F
{ 
internal 
static 
class 
CategoryDtoMapper +
{ 
internal 
static 
Category  

ToCategory! +
(+ ,
this, 0
CategoryDto1 <
dto= @
)@ A
{ 	
return		 
new		 
Category		 
(		  
)		  !
{

 
Id 
= 
dto 
. 
Id 
, 
Name 
= 
dto 
. 
Name 
,  
Image 
= 
dto 
. 
Image !
,! "
ParentCategoryId  
=! "
dto# &
.& '
ParentCategoryId' 7
,7 8
} 
; 
} 	
internal 
static 
CategoryDto #
ToDto$ )
() *
this* .
Category/ 7
category8 @
)@ A
{ 	
return 
new 
CategoryDto "
(" #
category# +
.+ ,
Id, .
,. /
category0 8
.8 9
Name9 =
,= >
category? G
.G H
ImageH M
,M N
categoryO W
.W X
ParentCategoryIdX h
)h i
;i j
} 	
} 
} Õ	
fE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Queries\Common\Dto\CategoryDto.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Queries0 7
.7 8
Common8 >
.> ?
Dto? B
;B C
public 
record 
CategoryDto 
( 
int 
Id  
,  !
string" (
Name) -
,- .
string/ 5
?5 6
Image7 <
,< =
int> A
?A B
ParentCategoryIdC S
)S T
:U V
IHyperlinkObjectW g
{ 
public		 

IReadOnlyCollection		 
<		 
HypermediaLink		 -
>		- .
Links		/ 4
{		5 6
get		7 :
;		: ;
init		< @
;		@ A
}		B C
=		D E#
HypermediaLinkGenerator		F ]
.		] ^
GenerateAll		^ i
(		i j
Id		j l
.		l m
ToString		m u
(		u v
)		v w
,		w x
$str			y Ö
)
		Ö Ü
;
		Ü á
}

 £	
wE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\UpdateCategory\UpdateCategoryValidator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
UpdateCategory9 G
;G H
public 
class #
UpdateCategoryValidator $
:% &
AbstractValidator' 8
<8 9!
UpdateCategoryCommand9 N
>N O
{ 
public		 
#
UpdateCategoryValidator		 "
(		" #
)		# $
{

 
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
NotEmpty %
(% &
)& '
.' (
MaximumLength( 5
(5 6
$num6 8
)8 9
;9 :
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
ValidUrl &
(& '
)' (
;( )
} 
} ˙
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\UpdateCategory\UpdateCategoryHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
UpdateCategory9 G
;G H
public 
class !
UpdateCategoryHandler "
(" #!
IApplicationDbContext# 8
	dbContext9 B
)B C
:D E
IRequestHandlerF U
<U V!
UpdateCategoryCommandV k
>k l
{ 
private 
readonly !
IApplicationDbContext *

_dbContext+ 5
=6 7
	dbContext8 A
;A B
public		 

async		 
Task		 
Handle		 
(		 !
UpdateCategoryCommand		 2
request		3 :
,		: ;
CancellationToken		< M
cancellationToken		N _
)		_ `
{

 
var 
category 
= 
await 

_dbContext '
.' (

Categories( 2
.2 3
	FindAsync3 <
(< =
[= >
request> E
.E F
IdF H
]H I
,I J
cancellationTokenK \
)\ ]
.] ^
ConfigureAwait^ l
(l m
falsem r
)r s
;s t
Guard 
. 
Against 
. 
NotFound 
( 
request &
.& '
Id' )
,) *
category+ 3
)3 4
;4 5
category 
. 
Image 
= 
request  
.  !
Image! &
;& '
category 
. 
Name 
= 
request 
.  
Name  $
;$ %
category 
. 
ParentCategoryId !
=" #
request$ +
.+ ,
ParentCategoryId, <
;< =
await 

_dbContext 
. 
SaveChangesAsync )
() *
cancellationToken* ;
); <
.< =
ConfigureAwait= K
(K L
falseL Q
)Q R
;R S
} 
} Ÿ
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\UpdateCategory\UpdateCategoryCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
UpdateCategory9 G
;G H
public 
record !
UpdateCategoryCommand #
(# $
int$ '
Id( *
,* +
string, 2
Name3 7
,7 8
string9 ?
?? @
ImageA F
,F G
intH K
?K L
ParentCategoryIdM ]
)] ^
:_ `
IRequesta i
;i j¬
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\DeleteCategory\DeleteCategoryHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
DeleteCategory9 G
{ 
public 

class !
DeleteCategoryHandler &
(& '!
IApplicationDbContext' <
	dbContext= F
)F G
:H I
IRequestHandlerJ Y
<Y Z!
DeleteCategoryCommandZ o
>o p
{ 
private 
readonly !
IApplicationDbContext .

_dbContext/ 9
=: ;
	dbContext< E
;E F
public		 
async		 
Task		 
Handle		  
(		  !!
DeleteCategoryCommand		! 6
request		7 >
,		> ?
CancellationToken		@ Q
cancellationToken		R c
)		c d
{

 	
var 
category 
= 
await  

_dbContext! +
.+ ,

Categories, 6
.6 7
	FindAsync7 @
(@ A
[A B
requestB I
.I J
IdJ L
]L M
,M N
cancellationTokenO `
)` a
.a b
ConfigureAwaitb p
(p q
falseq v
)v w
;w x
Guard 
. 
Against 
. 
NotFound "
(" #
request# *
.* +
Id+ -
,- .
category/ 7
)7 8
;8 9

_dbContext 
. 
Products 
.  
RemoveRange  +
(+ ,
category, 4
.4 5
Products5 =
)= >
;> ?

_dbContext 
. 

Categories !
.! "
Remove" (
(( )
category) 1
)1 2
;2 3
await 

_dbContext 
. 
SaveChangesAsync -
(- .
cancellationToken. ?
)? @
.@ A
ConfigureAwaitA O
(O P
falseP U
)U V
;V W
} 	
} 
} í
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\DeleteCategory\DeleteCategoryCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
DeleteCategory9 G
;G H
public 
record !
DeleteCategoryCommand #
(# $
int$ '
Id( *
)* +
:, -
IRequest. 6
;6 7£	
wE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\CreateCategory\CreateCategoryValidator.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
CreateCategory9 G
;G H
public 
class #
UpdateCategoryValidator $
:% &
AbstractValidator' 8
<8 9!
CreateCategoryCommand9 N
>N O
{ 
public		 
#
UpdateCategoryValidator		 "
(		" #
)		# $
{

 
RuleFor 
( 
x 
=> 
x 
. 
Name 
) 
. 
NotEmpty %
(% &
)& '
.' (
MaximumLength( 5
(5 6
$num6 8
)8 9
;9 :
RuleFor 
( 
x 
=> 
x 
. 
Image 
) 
. 
ValidUrl &
(& '
)' (
;( )
} 
} ∂
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\CreateCategory\CreateCategoryHandler.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
CreateCategory9 G
;G H
public 
class !
CreateCategoryHandler "
(" #!
IApplicationDbContext# 8
	dbContext9 B
)B C
:D E
IRequestHandlerF U
<U V!
CreateCategoryCommandV k
,k l
intm p
>p q
{ 
private 
readonly !
IApplicationDbContext *

_dbContext+ 5
=6 7
	dbContext8 A
;A B
public		 

async		 
Task		 
<		 
int		 
>		 
Handle		 !
(		! "!
CreateCategoryCommand		" 7
request		8 ?
,		? @
CancellationToken		A R
cancellationToken		S d
)		d e
{

 
var 
category 
= 
new 
Category #
{ 	
Name 
= 
request 
. 
Name 
,  
Image 
= 
request 
. 
Image !
,! "
ParentCategoryId 
= 
request &
.& '
ParentCategoryId' 7
} 	
;	 


_dbContext 
. 

Categories 
. 
Add !
(! "
category" *
)* +
;+ ,
await 

_dbContext 
. 
SaveChangesAsync )
() *
cancellationToken* ;
); <
.< =
ConfigureAwait= K
(K L
falseL Q
)Q R
;R S
return 
category 
. 
Id 
; 
} 
} Ú
uE:\repos\e-shop\CatalogService\CatalogService.Application\Categories\Commands\CreateCategory\CreateCategoryCommand.cs
	namespace 	
CatalogService
 
. 
Application $
.$ %

Categories% /
./ 0
Commands0 8
.8 9
CreateCategory9 G
;G H
public 
record !
CreateCategoryCommand #
(# $
)$ %
:& '
IRequest( 0
<0 1
int1 4
>4 5
{ 
public 

string 
Name 
{ 
get 
; 
init "
;" #
}$ %
=& '
string( .
.. /
Empty/ 4
;4 5
public 

string 
? 
Image 
{ 
get 
; 
init  $
;$ %
}& '
public		 

int		 
?		 
ParentCategoryId		  
{		! "
get		# &
;		& '
init		( ,
;		, -
}		. /
}

 