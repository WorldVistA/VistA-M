ICDIDX2 ;DLS/DEK - MUMPS Cross Reference Routine for History ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    None
 ;               
 ; Common Variables used:
 ; 
 ;    ICDCOD          ICD Code from Global
 ;    ICDCODX         ICD Code passed in (X)
 ;    ICDEFF          Effective Date
 ;    ICDSTA          Status
 ;    ICDNOD          Global Node (to reduce Global hits)
 ;    DA              IEN file 80, 80.1, 80.066 or 80.166
 ;    ICDIEN,DA(1)    IEN of file 80 or 80.1
 ;    ICDHIS          IEN of file 80.066 or 80.166
 ;    X               Data passed in to be indexed
 ;                 
 Q
SAHC(ICD) ; Code            .01      ACT1   Set
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN,ICDSYS,RT,EXC
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA)),RT) Q:+EXC'>0
 S ICDCODX=$G(X) Q:'$L(ICDCODX)  S ICDIEN=+($G(DA)) Q:+ICDIEN'>0
 Q:'$D(@(RT_+ICDIEN_",66)"))
 S ICDHIS=0 F  S ICDHIS=$O(@(RT_+ICDIEN_",66,"_ICDHIS_")")) Q:+ICDHIS=0  D
 . N DA,ICDSYS,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=ICDCODX Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  K ICDSYS D SHIS
 . S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 SHIS
 Q
KAHC(ICD) ; Code            .01      ACT1   Kill
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN,ICDSYS,RT
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S ICDCODX=$G(X) Q:'$L(ICDCODX)
 S ICDIEN=+($G(DA)) Q:+ICDIEN'>0  Q:'$D(@(RT_+ICDIEN_",66)"))
 S ICDHIS=0 F  S ICDHIS=$O(@(RT_+ICDIEN_",66,"_ICDHIS_")")) Q:+ICDHIS=0  D
 . N DA,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=ICDCODX Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  K ICDSYS D KHIS
 . S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 KHIS
 Q
SAHD(ICD) ; Effective Date  66,.01   ACT2   Set
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA(1))),RT) Q:+EXC'>0
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDSYS
 D HDC Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))  S ICDEFF=+($G(X)) Q:+ICDEFF=0  K ICDSYS D SHIS
 S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 SHIS
 Q
KAHD(ICD) ; Effective Date  66,.01   ACT2   Kill
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDSYS
 S RT=$$RT($G(ICD)) Q:'$L(RT)  D HDC Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))
 S ICDEFF=+($G(X)) Q:+ICDEFF=0  K ICDSYS D KHIS
 S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 KHIS
 Q
SAHS(ICD) ; Status          66,.02   ACT3   Set
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDSYS,RT,EXC
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA(1))),RT) Q:+EXC'>0
 D HDC Q:'$L($G(ICDCOD))  Q:+ICDEFF=0
 S ICDSTA=$G(X) Q:'$L(ICDSTA)  K ICDSYS D SHIS
 S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 SHIS
 Q
KAHS(ICD) ; Status          66,.02   ACT3   Kill
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDSYS,ICDSYS,RT
 S RT=$$RT($G(ICD)) Q:'$L(RT)
 D HDC Q:'$L($G(ICDCOD))  Q:+ICDEFF=0
 S ICDSTA=$G(X) Q:'$L(ICDSTA)  K ICDSYS D KHIS
 S ICDSYS=+($P($G(@(RT_+($G(DA(1)))_",1)")),"^",1)) D:+ICDSYS>0 KHIS
 Q
SAHCS(ICD) ; Coding System   1.1      ACT4   Set
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN,ICDSYS,RT,EXC
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA)),RT) Q:+EXC'>0
 S ICDSYS=$G(X) Q:'$L(ICDSYS)  S ICDIEN=+($G(DA)) Q:+ICDIEN'>0
 S EXC=$$EXC(DA) Q:+EXC'>0  Q:'$D(@(RT_+ICDIEN_",66)"))
 S ICDHIS=0 F  S ICDHIS=$O(@(RT_+ICDIEN_",66,"_ICDHIS_")")) Q:+ICDHIS=0  D
 . N DA,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=$P($G(@(RT_+ICDIEN_",0)")),"^",1) Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  D SHIS
 Q
KAHCS(ICD) ; Coding System   1.1      ACT4   Kill
 N ICDNOD,ICDSTA,ICDEFF,ICDCOD,ICDCODX,ICDHIS,ICDIEN,ICDSYS,RT
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S ICDSYS=$G(X) Q:'$L(ICDSYS)
 S ICDIEN=+($G(DA)) Q:+ICDIEN'>0  Q:'$D(@(RT_+ICDIEN_",66)"))
 S ICDHIS=0 F  S ICDHIS=$O(@(RT_+ICDIEN_",66,"_ICDHIS_")")) Q:+ICDHIS=0  D
 . N DA,X S DA=+ICDHIS,DA(1)=+ICDIEN D HDC
 . S ICDCOD=$P($G(@(RT_+ICDIEN_",0)")),"^",1) Q:'$L($G(ICDCOD))
 . Q:'$L($G(ICDEFF))  Q:'$L($G(ICDSTA))  D KHIS
 Q
SNUM(ICD) ; Code            .01      AN1    Set
 N RT,EXC,NUM,SYS
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA)),RT) Q:+EXC'>0
 S SYS=+($P($G(@(RT_+DA_",1)")),"^",1)) Q:+SYS'>0
 Q:'$L($G(X))  Q:+($G(DA))'>0
 S NUM=$$NUM^ICDEX(X) Q:+NUM'>0
 S @(RT_""""_"AN"_+SYS_""","_+NUM_","_+DA_")")=""
 Q
KNUM(ICD) ; Code            .01      AN1    Kill
 N RT,NUM,SYS
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S SYS=+($P($G(@(RT_+DA_",1)")),"^",1)) Q:+SYS'>0
 Q:'$L($G(X))  Q:+($G(DA))'>0  S NUM=$$NUM^ICDEX(X) Q:+NUM'>0
 K @(RT_""""_"AN"_+SYS_""","_+NUM_","_+DA_")")
 Q
SNUM2(ICD) ; Coding System   1.1      AN2    Set
 N RT,EXC,NUM,SYS,COD S SYS=+($G(X)) Q:+SYS'>0  Q:+($G(DA))'>0
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S EXC=$$EXC(+($G(DA)),RT) Q:+EXC'>0
 S COD=$P($G(@(RT_+DA_",0)")),"^",1) Q:'$L(COD)
 S NUM=$$NUM^ICDEX(COD) Q:+NUM'>0
 S @(RT_""""_"AN"_+SYS_""","_+NUM_","_+DA_")")=""
 Q
KNUM2(ICD) ; Coding System   1.1      AN2    Kill
 N RT,EXC,NUM,SYS,COD S SYS=+($G(X)) Q:+SYS'>0  Q:+($G(DA))'>0
 S RT=$$RT($G(ICD)) Q:'$L(RT)  S COD=$P($G(@(RT_+DA_",0)")),"^",1)
 Q:'$L(COD)  S NUM=$$NUM^ICDEX(COD) Q:+NUM'>0
 K @(RT_""""_"AN"_+SYS_""","_+NUM_","_+DA_")")
 Q
SSYS(ICD) ; Coding System - Static
 Q
KSYS(ICD) ; Coding System - Static
 Q
 ;    
 ; Miscellaneous
HDC ;   Set Common Variables (Code, Status and Effective Date)
 Q:'$L($G(RT))  S (ICDCOD,ICDSTA,ICDEFF)=""  Q:'$L($G(RT))
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(@(RT_+($G(DA(1)))_",66,"_+($G(DA))_",0)"))
 S ICDCOD=$P($G(@(RT_+($G(DA(1)))_",0)")),"^",1),ICDNOD=$G(@(RT_+($G(DA(1)))_",66,"_+($G(DA))_",0)"))
 S ICDSTA=$P(ICDNOD,"^",2),ICDEFF=$P(ICDNOD,"^",1)
 Q
SHIS ;   Set  ^ROOT("ACT",<code>,<status>,<date>,<ien>,<history>)
 ;   Set  ^ROOT("ACTS",<sys>,<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(RT))  N EXC Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 Q:'$D(@(RT_+($G(DA(1)))_",66,"_+($G(DA))_",0)"))
 Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))  Q:'$L($G(ICDEFF))
 S @(RT_"""ACT"","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")=""
 S:+($G(ICDSYS))>0 @(RT_"""ACTS"","_+ICDSYS_","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")=""
 I +($G(ICDSYS))'>0 D
 . N SYS S SYS=+($P($G(@(RT_+DA(1)_",1)")),"^",1))
 . S:+SYS>0 @(RT_"""ACTS"","_+SYS_","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")=""
 Q
KHIS ;   Kill ^ROOT("ACT",<code>,<status>,<date>,<ien>,<history>)
 ;   Kill ^ROOT("ACTS",<sys>,<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(RT))  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0  Q:'$D(@(RT_+($G(DA(1)))_",66,"_+($G(DA))_",0)"))
 Q:'$L($G(ICDCOD))  Q:'$L($G(ICDSTA))  Q:'$L($G(ICDEFF))
 K @(RT_"""ACT"","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")
 K:+($G(ICDSYS))>0 @(RT_"""ACTS"","_+ICDSYS_","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")
 I +($G(ICDSYS))'>0 D
 . N SYS S SYS=+($P($G(@(RT_+DA(1)_",1)")),"^",1))
 . K:+SYS>0 @(RT_"""ACTS"","_+SYS_","""_(ICDCOD_" ")_""","_+ICDSTA_","_+ICDEFF_","_+DA(1)_","_+DA_")")
 Q
EXC(X,Y) ;   Exclude from lookup
 N COD,EFF,LDS,IEN,RT S IEN=+($G(X)),RT=$G(Y) Q:+IEN'>0 0  Q:'$L(RT) 0  S COD=$P($G(@(RT_+IEN_",0)")),"^",1)
 S EFF=$O(@(RT_+IEN_",66,0)")),LDS=$O(@(RT_+IEN_",68,0)")) Q:$L(COD)&(+EFF>0)&(+LDS>0) 1
 Q 0
RT(X) ;   Root from File #
 Q $S(+($G(X))=80:$$ROOT^ICDEX(80),+($G(X))=80.1:$$ROOT^ICDEX(80.1),1:"")
