GMTSP36 ; SLC/KER - Oncology HS Comp Post-Install        ; 11/19/1999
 ;;2.7;Health Summary;**36**;Oct 20, 1995
 ;
 Q
POST ; Post Install
 ;                   
 ;  GMTSPKR  Minimum Version required for "Active" Component
 ;  GMTSPKV  Package Version in UCI
 ;  GMTSDAF  Disable Flag  ""=Active/"T"=Temporary/"P"=Permanent
 ;  GMTSOOM  Out of Order Message
 ;                                      
 I +$$VERSION^XPDUTL("GMTS")<2.7 D HSVNF Q
 N GMTSPKR,GMTSPKV,GMTSIOK,GMTSDAF,GMTSOOM,GMTSV1,GMTSV2,GMI,GMTJ,GMTNM,GMTSEG,GMTSI,GMTSIFN
 S GMTSIOK=1,GMTSV1=$$VERSION^XPDUTL("ONC"),GMTSV2=$$VERSION^XPDUTL("ONCO")
 S GMTSPKV=$S(GMTSV1>GMTSV2:GMTSV1,GMTSV2>GMTSV1:GMTSV2,1:GMTSV1)
 S GMTSPKR="2.11",GMTSOOM="",GMTSDAF=""
 S:+GMTSPKV<GMTSPKR GMTSDAF="T",GMTSOOM="Oncology Component requires v "_GMTSPKR
 D ADD(236,"ONCOLOGY","ONC","EXTRACT","GMTSONE",,,,"Oncology",,,GMTSDAF,GMTSOOM,1)
 D:GMTSIOK PDX("ONCOLOGY")
 Q
ADD(GMTSIEN,GMTSNAME,GMTSABBR,GMTSTAG,GMTSRTN,GMTSTIML,GMTSOCCL,GMTSSKEY,GMTSDHDN,GMTSICDT,GMTSPROV,GMTSDAF,GMTSDOOM,GMTSINCL) ; Add Component
 ;                 
 ;  ADD( )
 ;          GMTSIEN   Internal Entry Number File 142.1
 ;          GMTSNAME  Component Name
 ;          GMTSABBR  Abbreviation
 ;          GMTSTAG   Display Routine Tag
 ;          GMTSRTN   Display Routine
 ;          GMTSTIML  Time Limits Applicable
 ;          GMTSOCCL  Occurrence Limits Applicable
 ;          GMTSSKEY  Security Key (Component Locking)
 ;          GMTSDHDN  Default Header Name
 ;          GMTSICDT  ICD Text Applicable
 ;          GMTSPROV  Provider Narrative Text Applicable
 ;          GMTSDAF   Disable Flag (null, T or P)
 ;          GMTSOOM   Out of Order Message
 ;          GMTSINCL  Include Disabled in Ad Hoc (1/0)
 ;                          
 S GMTSNAME=$G(GMTSNAME),GMTSIEN=+($G(GMTSIEN)),GMTSRTN=$G(GMTSRTN)
 D:'$L($G(GMTSNAME))!(+($G(GMTSIEN))'>0)!('$L($G(GMTSRTN))) NOTOK
 Q:'$L($G(GMTSNAME))  Q:+($G(GMTSIEN))'>0  Q:'$L($G(GMTSRTN))
 N DIE,DIK,DA,DR,DIC,DLAYGO,DINUM,X,Y,INCLUDE,GMTS,GMTSROUT,GMTSTAT
 S GMTSROUT="",GMTSTAT=$D(^GMT(142.1,+GMTSIEN,0))
 S GMTS=+$O(^GMT(142.1,"B",GMTSNAME,0)) D:GMTS=GMTSIEN ALRDY,NOTOK Q:GMTS=GMTSIEN
 D INST S GMTSNAME=$$NAME($G(GMTSNAME)) D:'$L($G(GMTSNAME)) NNAME,NOTOK Q:'$L(GMTSNAME)
 S GMTSTAG=$G(GMTSTAG),GMTSRTN=$G(GMTSRTN) S GMTSROUT=$$ROUT((GMTSTAG_";"_GMTSRTN))
 D:'$L($G(GMTSROUT)) NRTN,NOTOK Q:'$L(GMTSROUT)  S GMTSTIML=$$TIML($G(GMTSTIML))
 S GMTSOCCL=$$OCCL($G(GMTSOCCL)) S GMTSABBR=$$ABBR($G(GMTSABBR)) S GMTSSKEY=$$LOCK($G(GMTSSKEY))
 S GMTSDHDN=$$DHDN($G(GMTSDHDN)) S GMTSICDT=$$ICDT($G(GMTSICDT))
 S GMTSPROV=$$PROV($G(GMTSPROV)) S GMTSDAF=$$DAF($G(GMTSDAF)) S GMTSOOM=$$OOM($G(GMTSOOM))
 S:$L(GMTSDAF)&('$L(GMTSOOM)) GMTSOOM="Component "_GMTSNAME_$S(GMTSDAF="T":" Temporarily",GMTSDAF="P":" Permanently",1:"")_" Disabled"
 S DINUM=0,(DIC,DLAYGO)=142.1,DIC(0)="NXL",X=GMTSNAME S:'$D(^GMT(142.1,+($G(GMTSIEN)),0)) DINUM=+($G(GMTSIEN)) I +DINUM'>1 D EXIST,NOTOK Q
 D ^DIC D:+($G(Y))'>0 FAILED,NOTOK Q:+($G(Y))'>0  S GMTSNAME=$$NAME($G(GMTSNAME)) D:'$L($G(GMTSNAME)) NNAME,NOTOK Q:'$L(GMTSNAME)
 S DIE=DIC,DA=+($G(Y)),DR="1///^S X="""_$G(GMTSTAG)_"""_$C(59)_"""_$G(GMTSRTN)_""""
 S:$L($G(GMTSTIML)) DR=DR_";2///"_GMTSTIML S:$L($G(GMTSABBR)) DR=DR_";3///"_GMTSABBR S:$L($G(GMTSOCCL)) DR=DR_";4///"_GMTSOCCL
 S:$L($G(GMTSDAF)) DR=DR_";5///"_GMTSDAF S:$L($G(GMTSSKEY)) DR=DR_";6///"_GMTSSKEY S:$L($G(GMTSOOM)) DR=DR_";8///"_GMTSOOM
 S:$L($G(GMTSDHDN)) DR=DR_";9///"_GMTSDHDN S:$L($G(GMTSICDT)) DR=DR_";11///"_GMTSICDT S:$L($G(GMTSPROV)) DR=DR_";12///"_GMTSPROV
 D ^DIE,DES S DIK=DIE D IX^DIK D:GMTSTAT&($D(^GMT(142.1,+($G(DA)),0))) SCESE D:'GMTSTAT&($D(^GMT(142.1,+($G(DA)),0))) SCESS
 I +($G(GMTSINCL)) S INCLUDE=0 D ENPOST^GMTSLOAD
 Q
PDX(GMTSCOMP,GMTSTIM,GMTSOCC) ; Install PDX Data Segment
 ;                    
 ;  PDX( )
 ;          GMTSCOMP   Component Name (.01 of 142.1)
 ;          GMTSTIM    Time Limits Applicable
 ;          GMTSOCC    Occurrence Limits Applicable
 ;               
 N GMTSNAME,GMTSERR,GMTS Q:'$L(GMTSCOMP)
 S (GMTS,GMTSERR)="",GMTSTIM=$G(GMTSTIM),GMTSOCC=$G(GMTSOCC),GMTSNAME=$$FIRSTUP^VAQUTL50(GMTSCOMP)
 D INSP S GMTS=+$O(^GMT(142.1,"B",GMTSCOMP,0)) I ('GMTS) D NOPDX Q
 S GMTSERR=$$ADDSEG^VAQUTL50(GMTS,GMTSTIM,GMTSOCC) I (GMTSERR<0) D PDXER Q
 D PDXOK
 Q
 ; Check Input
NAME(X) ;   Check Name (required)
 S X=$G(X) K:X[""""!($A(X)=45) X Q:'$D(X) ""
 I $D(X) K:$L(X)>30!($L(X)<3)!'(X'?1P.E) X
 I $L($G(X)),'$D(^GMT(142.1,+($G(Y)),0)) D
 . K:$D(^GMT(142.1,"B",X)) X Q:'$D(X)  Q:+($G(Y))'>0  I $P($G(^GMT(142.1,+($G(Y)),0)),"^",1)'=$G(X) K X
 S X=$G(X) Q X
ROUT(X) ;   Check Routine (required)
 S X=$G(X) K:X[""""!($A(X)=45) X Q:'$D(X) ""
 K:$L(X)>17!($L(X)<3)!'(X?1U1.7UN1";"1U1.7UN) X Q:'$D(X) ""
 I @("$L($T("_$P(X,";")_"^"_$P(X,";",2)_"))'>0") K X
 S X=$G(X) Q X
TIML(X) ;   Check Time Limits
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
ABBR(X) ;   Check Abbreviation
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>4!($L(X)<2)!'(X?2.4UN) X="" Q X
OCCL(X) ;   Check Occurrence Limits
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
LOCK(X) ;   Check Lock
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>30!($L(X)<1) X="" Q:'$L(X) "" S:'$D(^DIC(19.1,"B",X)) X="" Q X
DHDN(X) ;   Check Default Header Name
 S X=$G(X) S:X[""""!($A(X)=45) X="" S:$L(X)>20!($L(X)<2) X="" Q X
ICDT(X) ;   Check ICD Text Flag
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
PROV(X) ;   Check Provider Narrative Flag
 S X=$G(X) Q:X="1"!(X="Y") "Y" Q ""
DAF(X) ;   Check Disable Flag
 S X=$G(X) Q:X="T" "T" Q:X="T" "P" Q ""
OOM(X) ;   Check Out of Order Message
 S X=$G(X) Q:$L(X)<3 "" Q:$L(X)>78 "" Q X
 Q
 ;              
 ; Messages
 ;   Health Summary Type messages
HSVNF ;     Health Summary Version not found
 N GMTST S GMTST="   Health Summary Version 2.7 not found" D BM(GMTST) Q
NNAME ;     No Name
 N GMTST S GMTST="   No or invalid Health Summary Component name" D BM(GMTST) D NOTI Q
NRTN ;     No Routine
 N GMTST S GMTST="   No or invalid Health Summary display routine" D BM(GMTST) D NOTI Q
INST ;     Installing Component
 N GMTST S GMTST=" Filing "_GMTSNAME_" component in HEALTH SUMMARY COMPONENT FILE (#142.1)" D BM(GMTST) Q
NOTI ;     Not Installed
 N GMTST S GMTST="   Could not install new component" D M(GMTST) Q
EXIST ;     DINUMed entry Exist
 N GMTST S GMTST="   Can not add component, DINUM'ed entry already exist" D BM(GMTST) Q
ALRDY ;     Component Already Installed
 N GMTST S GMTST="   "_GMTSNAME_" component has already been installed" D BM(GMTST) S GMTST="   in the HEALTH SUMMARY COMPONENT FILE (#142.1)" D M(GMTST) Q
FAILED ;     Failed Installation
 N GMTST S GMTST="   Failed to install "_GMTSNAME_" component" D BM(GMTST) Q
SCESS ;     Successfully Installed
 N GMTSD S GMTSD=0 D DISAB Q:+($G(GMTSD))
 N GMTST S GMTST="   Successfully installed the "_GMTSNAME_" component" D BM(GMTST) Q
SCESE ;     Successfully Edited
 N GMTSD S GMTSD=0 D DISAB Q:+($G(GMTSD))
 N GMTST S GMTST="   Successfully edited/updated the "_GMTSNAME_" component" D BM(GMTST) Q
DISAB ;
 Q:+($G(GMTSIEN))=0  Q:$P($G(^GMT(142.1,+($G(GMTSIEN)),0)),"^",6)=""
 N GMTSF,GMTSM,GMTST S GMTSF=$P($G(^GMT(142.1,+($G(GMTSIEN)),0)),"^",6)
 S GMTSF=$S(GMTSF="T":"Temporarily",GMTSF="P":"Permanently",1:"") Q:'$L(GMTSF)
 S GMTSD=1,GMTST="",GMTSM=$P($G(^GMT(142.1,+($G(GMTSIEN)),0)),"^",8)
 S GMTST="   Componet "_GMTSNAME_" is installed, but "_GMTSF_" disabled" D BM(GMTST)
 S GMTST="" S:$L(GMTSM) GMTST="   Out of order message:  """_GMTSM_"""" D:$L(GMTST) M(GMTST)
 Q
 ;   PDX Messages
INSP ;     Installing PDX Segment
 N GMTST S GMTST=" Filing "_GMTSCOMP_" component in PDX Data Segments" D BM(GMTST) Q
NOPDX ;     No PDX Segment Installed
 N GMTST S GMTST="   "_GMTSCOMP_" not found in HEALTH SUMMARY COMPONENT file." D BM(GMTST) S GMTST="   "_GMTSNAME_" not added to VAQ - DATA SEGMENT file." D M(GMTST),M("") Q
PDXER ;     Error filing PDX Segment
 N GMTST S GMTST=$P($G(GMTSERR),"^",2) Q:'$L(GMTST)  S GMTST="   "_GMTST D BM(GMTST),M("") Q
PDXOK ;     PDX Segment filled ok
 N GMTST S GMTST="   "_GMTSNAME_" added to VAQ - DATA SEGMENT file (#394.71)." D BM(GMTST),M("") Q
 ;   Message Lines
NOTOK ;     Install is not OK
 S:+($G(GMTSIOK))>0 GMTSIOK=0 Q
BM(X) ;     Blank Line with Message
 D:$D(XPDNM) BMES^XPDUTL($G(X)) W:'$D(XPDNM) !!,$G(X) Q
M(X) ;     Message
 D:$D(XPDNM) MES^XPDUTL($G(X)) W:'$D(XPDNM) !,$G(X) Q
 ;                    
DES ; Description
 Q:+($G(GMTSIEN))=0  Q:+($G(DT))=0  Q:'$D(^GMT(142.1,+GMTSIEN,0))
SDES ;   Save Description
 N GMTSX,GMTSI,GMTST,GMTSC,GMTSHN,GMTSNN,GMTSHD,GMTSH
 S GMTSH="^GMT(142.1,"_GMTSIEN_",3.5)",GMTST="",GMTSC=0
 F GMTSI=1:1 D  Q:'$L(GMTST)
 . S GMTST="" S GMTSX="S GMTST=$T(DEST+"_GMTSI_"^GMTSP36)" X GMTSX S GMTST=$P(GMTST,";",2) Q:'$L(GMTST)
 . S GMTSC=GMTSC+1 K:GMTSC=1 @GMTSH S GMTSHN="^GMT(142.1,"_GMTSIEN_",3.5,0)",GMTSHD="^^"_GMTSC_"^"_GMTSC_"^"_DT_"^",GMTSNN="^GMT(142.1,"_GMTSIEN_",3.5,"_GMTSC_",0)"
 . S @GMTSHN=GMTSHD,@GMTSNN=GMTST
 Q
DEST ;   Description Text
 ;This component will extract selected data items from the
 ;ONCOLOGY PRIMARY file.  
 ;;
