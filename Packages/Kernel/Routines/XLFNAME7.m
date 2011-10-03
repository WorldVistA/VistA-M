XLFNAME7 ;BPOIFO/KEITH - NAME STANDARDIZATION ; 27 Jan 2002 11:05 PM
 ;;8.0;KERNEL;**343**; Jul 10, 1995;
 ;
FORMAT(XUNAME,XUMINL,XUMAXL,XUNOP,XUCOMA,XUAUDIT,XUFAM,XUDNC) ;Format name value
 ;Input: XUNAME=text value representing person name to transform
 ;       XUMINL=minimum length (optional), default 3
 ;       XUMAXL=maximum length (optional), default 30
 ;        XUNOP=1 to standardize last name for 'NOP' x-ref 
 ;                (for the PAITNE file). (optional)
 ;       XUCOMA=0 to not require a comma
 ;              1 to require a comma in the input value
 ;              2 to add a comma if none
 ;              3 to prohibit (remove) commas
 ;              (optional) default if not specified is 1
 ;
 ;      XUAUDIT=variable to return audit, pass by reference (optional),
 ;              returned values:  
 ;              XUAUDIT=0 if no change was made
 ;                      1 if name is changed
 ;                      2 if name could not be converted
 ;             XUAUDIT(1) defined if name contains no comma
 ;             XUAUDIT(2) defined if parenthetical text is removed
 ;             XUAUDIT(3) defined if value is unconvertible
 ;             XUAUDIT(4) defined if characters are removed or changed
 ;        XUFAM='1' if just the family name, '0' otherwise (optional)
 ;        XUDNC='1' to prevent componentization (optional)
 ;             ='2' to return components before standardize
 ;
 ;Output: XUNAME in specified format or null if length of transformed value is less than XUMINL
 ;
 N XUX,XUOX,XUOLDN,XUAX,XUI,XUNEWN
 ;Initialize variables
 K XUAUDIT
 S XUOLDN=XUNAME M XUX=XUNAME
 S XUDNC=$G(XUDNC) D COMP^XLFNAME8(.XUX,.XUDNC)
 S XUMINL=+$G(XUMINL) S:XUMINL<1 XUMINL=3
 S XUMAXL=+$G(XUMAXL) S:XUMAXL<XUMINL XUMAXL=30
 S XUNOP=$S($G(XUNOP)=1:"S",1:"")
 S:'$L($G(XUCOMA)) XUCOMA=1 S XUCOMA=+XUCOMA
 S XUFAM=$S($G(XUFAM)=1:"F",1:"")
 ;
 ;Check for comma
 I XUX'["," S XUAUDIT(1)=""
 I XUCOMA=1,XUX'["," S XUAUDIT=2,XUAUDIT(3)=""  Q ""
 ;Clean input value
 F  Q:'$$F1^XLFNAME8(.XUX,XUCOMA)
 I XUX'=XUOLDN S XUAUDIT(4)=""
 ;Add comma if necessary
 I XUCOMA=2,XUX'[" ",XUX'["," S XUX=XUX_","
 I XUX=XUOLDN K XUAUDIT(4)
 ;Quit if result is too short
 I $L(XUX)<XUMINL S XUAUDIT=2,XUAUDIT(3)="" K XUNAME Q ""
 S XUNAME=XUX I XUDNC'=1 D
 .;Parse the name
 .D STDNAME^XLFNAME(.XUX,XUFAM_"CP",.XUAX)
 .I $D(XUAX("STRIP")) S XUAUDIT(2)=""
 .I $D(XUAX("NM"))!$D(XUAX("PERIOD")) S XUAUDIT(4)=""
 .I $D(XUAX("PUNC"))!($D(XUAX("SPACE"))&'$L(XUFAM)) S XUAUDIT(4)=""
 .I $D(XUAX("SPACE")),$L(XUFAM),XUNAME'=$G(XUX("FAMILY")) S XUAUDIT(4)=""
 .;Standardize the suffix
 .S XUX("SUFFIX")=$$CLEANC^XLFNAME(XUX("SUFFIX"))
 .;Post-clean components
 .S XUI="" F  S XUI=$O(XUX(XUI)) Q:XUI=""  S XUX(XUI)=$$POSTC(XUX(XUI))
 .;Reconstruct name from components
 .S XUNAME=$$NAMEFMT^XLFNAME(.XUX,"F","CL"_XUMAXL_XUNOP)
 .;Adjust name for 'do not componentize'
 .;I XUDNC S XUNAME=XUX("FAMILY")
 ;Return comma for single value names
 I XUCOMA,XUCOMA'=3,XUNAME'["," S XUNAME=XUNAME_","
 ;Check length again
 I $L(XUNAME)<XUMINL S XUAUDIT=2,XUAUDIT(3)="" K XUNAME Q ""
 ;Enforce minimum 2 character last name rule
 ;I '$L(XUFAM),$L($P(XUNAME,","))<3,$P(XUNAME,",")'?2U D  Q ""
 ;.S XUAUDIT=2,XUAUDIT(3)="" K XUNAME
 ;.Q
 ;Remove hyphens and apostrophes for 'NOP' x-ref
 S XUX=XUNAME I XUNOP="S" S XUNAME=$TR(XUNAME,"'-")
 I XUNAME'=XUX S XUAUDIT(4)=""
 I XUNAME=XUOLDN K XUAUDIT
 S XUAUDIT=XUNAME'=XUOLDN I XUAUDIT,$D(XUAUDIT)<10 S XUAUDIT(4)=""
 S XUNEWN=XUNAME M XUNAME=XUX S XUNAME=XUNEWN
 ;Return components before standardization if asked to
 I XUDNC=2 D
 . N XUNAMEC
 . S XUNAMEC=XUNAME
 . I XUOLDN["`" S XUOLDN=$TR(XUOLDN,"`","'")
 . D STDNAME^XLFNAME(.XUOLDN,"C")
 . M XUNAME=XUOLDN
 . S XUNAME=XUNAMEC
 Q XUNAME
 ;
POSTC(XUX) ;Post-clean components
 ;Remove parenthesis if not removed by Kernel
 N XUI,XUXOLD
 S XUXOLD=XUX,XUX=$TR(XUX,"()[]{}")
 ;Check for numbers left behind by Kernel
 F XUI=0:1:9 S XUX=$TR(XUX,XUI)
 I XUX'=XUXOLD S XUAUDIT(4)=""
 Q XUX
 ;
NOP(XUX) ;Produce 'NOP' x-ref value
 ;Input: XUX=name value to evaluate
 ;Output : Standardized name or null if the same as input value
 N XUNEWX
 S XUNEWX=$$FORMAT(XUX,3,30,1)
 Q $S(XUX=XUNEWX:"",1:XUNEWX)
 ;
NARY(XU20NAME) ;Set up name array
 ;Input: XU20NAME=full name value
 ;       XU20NAME(component_names)=corresponding value--if undefined,
 ;                these will get set up
 ;
 N XUX M XUX=XU20NAME
 D STDNAME^XLFNAME(.XU20NAME,"FC")
 M XU20NAME=XUX
 S XU20NAME("NOTES")=$$NOTES^XLFNAME8()
 Q
 ;
