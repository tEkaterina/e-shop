û;
gE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\Migrations\20241008221051_InitialCreate.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

Migrations( 2
{ 
public 

partial 
class 
InitialCreate &
:' (
	Migration) 2
{		 
	protected 
override 
void 
Up  "
(" #
MigrationBuilder# 3
migrationBuilder4 D
)D E
{ 	
migrationBuilder 
. 
CreateTable (
(( )
name 
: 
$str "
," #
columns 
: 
table 
=> !
new" %
{ 
Id 
= 
table 
. 
Column %
<% &
int& )
>) *
(* +
type+ /
:/ 0
$str1 :
,: ;
nullable< D
:D E
falseF K
)K L
. 

Annotation #
(# $
$str$ :
,: ;
true< @
)@ A
,A B
Name 
= 
table  
.  !
Column! '
<' (
string( .
>. /
(/ 0
type0 4
:4 5
$str6 <
,< =
nullable> F
:F G
falseH M
)M N
,N O
Image 
= 
table !
.! "
Column" (
<( )
string) /
>/ 0
(0 1
type1 5
:5 6
$str7 =
,= >
nullable? G
:G H
trueI M
)M N
,N O
ParentCategoryId $
=% &
table' ,
., -
Column- 3
<3 4
int4 7
>7 8
(8 9
type9 =
:= >
$str? H
,H I
nullableJ R
:R S
trueT X
)X Y
} 
, 
constraints 
: 
table "
=># %
{ 
table 
. 

PrimaryKey $
($ %
$str% 4
,4 5
x6 7
=>8 :
x; <
.< =
Id= ?
)? @
;@ A
table 
. 

ForeignKey $
($ %
name 
: 
$str I
,I J
column 
: 
x  !
=>" $
x% &
.& '
ParentCategoryId' 7
,7 8
principalTable &
:& '
$str( 4
,4 5
principalColumn '
:' (
$str) -
)- .
;. /
} 
) 
; 
migrationBuilder!! 
.!! 
CreateTable!! (
(!!( )
name"" 
:"" 
$str""  
,""  !
columns## 
:## 
table## 
=>## !
new##" %
{$$ 
Id%% 
=%% 
table%% 
.%% 
Column%% %
<%%% &
int%%& )
>%%) *
(%%* +
type%%+ /
:%%/ 0
$str%%1 :
,%%: ;
nullable%%< D
:%%D E
false%%F K
)%%K L
.&& 

Annotation&& #
(&&# $
$str&&$ :
,&&: ;
true&&< @
)&&@ A
,&&A B
Name'' 
='' 
table''  
.''  !
Column''! '
<''' (
string''( .
>''. /
(''/ 0
type''0 4
:''4 5
$str''6 <
,''< =
nullable''> F
:''F G
false''H M
)''M N
,''N O
Price(( 
=(( 
table(( !
.((! "
Column((" (
<((( )
decimal(() 0
>((0 1
(((1 2
type((2 6
:((6 7
$str((8 >
,((> ?
nullable((@ H
:((H I
false((J O
)((O P
,((P Q
Description)) 
=))  !
table))" '
.))' (
Column))( .
<)). /
string))/ 5
>))5 6
())6 7
type))7 ;
:)); <
$str))= C
,))C D
nullable))E M
:))M N
true))O S
)))S T
,))T U
Image** 
=** 
table** !
.**! "
Column**" (
<**( )
string**) /
>**/ 0
(**0 1
type**1 5
:**5 6
$str**7 =
,**= >
nullable**? G
:**G H
true**I M
)**M N
,**N O
Amount++ 
=++ 
table++ "
.++" #
Column++# )
<++) *
int++* -
>++- .
(++. /
type++/ 3
:++3 4
$str++5 >
,++> ?
nullable++@ H
:++H I
false++J O
)++O P
,++P Q

CategoryId,, 
=,,  
table,,! &
.,,& '
Column,,' -
<,,- .
int,,. 1
>,,1 2
(,,2 3
type,,3 7
:,,7 8
$str,,9 B
,,,B C
nullable,,D L
:,,L M
false,,N S
),,S T
}-- 
,-- 
constraints.. 
:.. 
table.. "
=>..# %
{// 
table00 
.00 

PrimaryKey00 $
(00$ %
$str00% 2
,002 3
x004 5
=>006 8
x009 :
.00: ;
Id00; =
)00= >
;00> ?
table11 
.11 

ForeignKey11 $
(11$ %
name22 
:22 
$str22 A
,22A B
column33 
:33 
x33  !
=>33" $
x33% &
.33& '

CategoryId33' 1
,331 2
principalTable44 &
:44& '
$str44( 4
,444 5
principalColumn55 '
:55' (
$str55) -
,55- .
onDelete66  
:66  !
ReferentialAction66" 3
.663 4
Cascade664 ;
)66; <
;66< =
}77 
)77 
;77 
migrationBuilder99 
.99 
CreateIndex99 (
(99( )
name:: 
::: 
$str:: 6
,::6 7
table;; 
:;; 
$str;; #
,;;# $
column<< 
:<< 
$str<< *
)<<* +
;<<+ ,
migrationBuilder>> 
.>> 
CreateIndex>> (
(>>( )
name?? 
:?? 
$str?? .
,??. /
table@@ 
:@@ 
$str@@ !
,@@! "
columnAA 
:AA 
$strAA $
)AA$ %
;AA% &
}BB 	
	protectedEE 
overrideEE 
voidEE 
DownEE  $
(EE$ %
MigrationBuilderEE% 5
migrationBuilderEE6 F
)EEF G
{FF 	
migrationBuilderGG 
.GG 
	DropTableGG &
(GG& '
nameHH 
:HH 
$strHH  
)HH  !
;HH! "
migrationBuilderJJ 
.JJ 
	DropTableJJ &
(JJ& '
nameKK 
:KK 
$strKK "
)KK" #
;KK# $
}LL 	
}MM 
}NN ¯
`E:\repos\e-shop\CatalogService\CatalogService.Infrastructure\MessageBroker\MessageBrokerConst.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (
MessageBroker( 5
;5 6
internal 
static	 
class 
MessageBrokerConst (
{ 
internal 
static 
string 
ProductSyncQueue +
=, -
$str. @
;@ A
} ä
iE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\MessageBroker\ApplicationMessagePublisher.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (
MessageBroker( 5
;5 6
public 
class '
ApplicationMessagePublisher (
(( )
IMessageBroker) 7
broker8 >
)> ?
:@ A(
IApplicationMessagePublisherB ^
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
 %
PublishProductUpdateAsync

 /
(

/ 0
ProductChangeEvent

0 B
message

C J
)

J K
{ 
await 
broker 
. 
PublishAsync !
(! "
MessageBrokerConst" 4
.4 5
ProductSyncQueue5 E
,E F
messageG N
)N O
.O P
ConfigureAwaitP ^
(^ _
false_ d
)d e
;e f
} 
} N
LE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\GlobalUsings.csø
SE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DependencyInjection.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
;' (
public 
static 
class 
DependencyInjection '
{ 
public 

static 
IServiceCollection $%
AddInfrastructureServices% >
(> ?
this? C
IServiceCollectionD V
servicesW _
,_ `
IConfigurationa o
configurationp }
)} ~
{ 
var 
connectionString 
= 
configuration ,
., -
GetConnectionString- @
(@ A
$strA T
)T U
;U V
Guard 
. 
Against 
. 
NullOrEmpty !
(! "
connectionString" 2
)2 3
;3 4
services 
. 
AddDbContext 
<  
ApplicationDbContext 2
>2 3
(3 4
options4 ;
=>< >
{ 	
options 
. 
	UseSqlite 
( 
connectionString .
). /
;/ 0
} 	
)	 

;
 
services 
. 
	AddScoped 
< !
IApplicationDbContext 0
>0 1
(1 2
options2 9
=>: <
options= D
.D E
GetRequiredServiceE W
<W X 
ApplicationDbContextX l
>l m
(m n
)n o
)o p
;p q
services 
. 
	AddScoped 
< 
IDbInitializer )
,) *
DbInitializer+ 8
>8 9
(9 :
): ;
;; <
services 
. 
	AddScoped 
< (
IApplicationMessagePublisher 7
,7 8'
ApplicationMessagePublisher9 T
>T U
(U V
)V W
;W X
services 
. 
AddMessageBroker !
(! "
configuration" /
)/ 0
;0 1
return   
services   
;   
}!! 
}"" ®
YE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DataAccess\IDbInitializer.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

DataAccess( 2
;2 3
public 
	interface 
IDbInitializer 
{ 
Task 
InitializeAsync	 
( 
) 
; 
} €
lE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DataAccess\EntityConfigs\ProductEntityConfig.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

DataAccess( 2
.2 3
EntityConfigs3 @
{ 
public 

class 
ProductEntityConfig $
:% &$
IEntityTypeConfiguration' ?
<? @
Product@ G
>G H
{ 
public 
void 
	Configure 
( 
EntityTypeBuilder /
</ 0
Product0 7
>7 8
builder9 @
)@ A
{		 	
builder

 
.

 
ToTable

 
(

 
$str

 &
)

& '
;

' (
} 	
} 
} ﬂ
mE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DataAccess\EntityConfigs\CategoryEntityConfig.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

DataAccess( 2
.2 3
EntityConfigs3 @
{ 
public 

class  
CategoryEntityConfig %
:& '$
IEntityTypeConfiguration( @
<@ A
CategoryA I
>I J
{ 
public 
void 
	Configure 
( 
EntityTypeBuilder /
</ 0
Category0 8
>8 9
builder: A
)A B
{		 	
builder

 
.

 
ToTable

 
(

 
$str

 (
)

( )
;

) *
} 	
} 
} ◊
XE:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DataAccess\DbInitializer.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

DataAccess( 2
;2 3
public 
class 
DbInitializer 
(  
ApplicationDbContext /
context0 7
)7 8
:9 :
IDbInitializer; I
{ 
public 

async 
Task 
InitializeAsync %
(% &
)& '
{ 
await		 
context		 
.		 
Database		 
.		 
MigrateAsync		 +
(		+ ,
)		, -
.		- .
ConfigureAwait		. <
(		< =
false		= B
)		B C
;		C D
}

 
} °
_E:\repos\e-shop\CatalogService\CatalogService.Infrastructure\DataAccess\ApplicationDbContext.cs
	namespace 	
CatalogService
 
. 
Infrastructure '
.' (

DataAccess( 2
{ 
public		 

class		  
ApplicationDbContext		 %
(		% &
DbContextOptions		& 6
<		6 7 
ApplicationDbContext		7 K
>		K L
options		M T
)		T U
:		V W
	DbContext		X a
(		a b
options		b i
)		i j
,		j k"
IApplicationDbContext			l Å
{

 
public 
DbSet 
< 
Product 
> 
Products &
=>' )
Set* -
<- .
Product. 5
>5 6
(6 7
)7 8
;8 9
public 
DbSet 
< 
Category 
> 

Categories )
=>* ,
Set- 0
<0 1
Category1 9
>9 :
(: ;
); <
;< =
	protected 
override 
void 
OnModelCreating  /
(/ 0
ModelBuilder0 <
modelBuilder= I
)I J
{ 	
base 
. 
OnModelCreating  
(  !
modelBuilder! -
)- .
;. /
modelBuilder 
. +
ApplyConfigurationsFromAssembly 8
(8 9
Assembly9 A
.A B 
GetExecutingAssemblyB V
(V W
)W X
)X Y
;Y Z
} 	
} 
} 