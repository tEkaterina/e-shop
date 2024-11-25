�	
QE:\repos\e-shop\CatalogService\CatalogService.Domain\Events\ProductChangeEvent.cs
	namespace 	
CatalogService
 
. 
Domain 
.  
Events  &
;& '
public 
record 
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
record 
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
} �
HE:\repos\e-shop\CatalogService\CatalogService.Domain\Entities\Product.cs
	namespace 	
CatalogService
 
. 
Domain 
.  
Entities  (
;( )
public 
record 
Product 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
string' -
.- .
Empty. 3
;3 4
public		 

decimal		 
Price		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
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
public

string
?
Image
{
get
;
set
;
}
public 

int 
Amount 
{ 
get 
; 
set  
;  !
}" #
public 

int 

CategoryId 
{ 
get 
;  
set! $
;$ %
}& '
public 

Category 
Category 
{ 
get "
;" #
set$ '
;' (
}) *
=+ ,
null- 1
!1 2
;2 3
} �
IE:\repos\e-shop\CatalogService\CatalogService.Domain\Entities\Category.cs
	namespace 	
CatalogService
 
. 
Domain 
.  
Entities  (
;( )
public 
record 
Category 
{ 
public 

int 
Id 
{ 
get 
; 
set 
; 
} 
public 

string 
Name 
{ 
get 
; 
set !
;! "
}# $
=% &
string' -
.- .
Empty. 3
;3 4
public		 

string		 
?		 
Image		 
{		 
get		 
;		 
set		  #
;		# $
}		% &
public 

int 
? 
ParentCategoryId  
{! "
get# &
;& '
set( +
;+ ,
}- .
public

Category
?
ParentCategory
{
get
;
set
;
}
public 

IList 
< 
Category 
> 
ChildCategories *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
=: ;
[< =
]= >
;> ?
public 

IList 
< 
Product 
> 
Products "
{# $
get% (
;( )
init* .
;. /
}0 1
=2 3
[4 5
]5 6
;6 7
} 