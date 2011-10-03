DGREGAED ;ALB/DW/PHH,BAJ,TDM - Address Edit API; 01/03/2006 ; 4/2/09 2:29pm
 ;;5.3;Registration;**522,560,658,730,688,808**;Aug 13, 1993;Build 4
 ;;
 ;; **688** Modifications for Country and Foreign address
 ;
EN(DFN,FLG,SRC) ;Entry point
 ;Input: 
 ;  DFN (required) - Internal Entry # of Patient File (#2)
 ;  FLG (optional) - Flags of 1 or 0; if null, 0 is assumed. Details:
 ;    FLG(1) - if 1 let user edit phone numbers (field #.131 and #.132)
 ;    FLG(2) - if 1 display before & after address for user confirmation
 K EASZIPLK
 N DGINPUT,DGCMP,ICNTRY,CNTRY,FORGN,PSTR,OLDC
 N I,X,Y
 I $G(DFN)="" Q
 ;I ($G(DFN)'?.N) Q
 S FLG(1)=$G(FLG(1)),FLG(2)=$G(FLG(2))
 D GETOLD(.DGCMP,DFN)
 S CNTRY="",ICNTRY=$P($G(^DPT(DFN,.11)),"^",10) I ICNTRY="" S ICNTRY=1  ;default country is USA if NULL
 S OLDC=DGCMP("OLD",.1173),FORGN=$$FOREIGN^DGADDUTL(DFN,ICNTRY,2,.1173,.CNTRY) I FORGN=-1 Q
 S FSTR=$$INPT1(DFN,FORGN,.PSTR)       ;set up field string of address prompts
 S DGINPUT=1 D INPUT(.DGINPUT,DFN,FSTR,CNTRY) I $G(DGINPUT)=-1 Q
 I $G(FLG(2))=1 D COMPARE(.DGINPUT,.DGCMP,.FLG)
 I '$$CONFIRM() W !,"Change aborted." D EOP Q
 N DGPRIOR
 D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 D SAVE(.DGINPUT,DFN,FSTR,FORGN) I $G(SRC)="",+$G(DGNEW) Q
 Q:'$$FILEYN^DGADDUTL(.DGPRIOR,.DGINPUT)
 D GETUPDTS^DGADDUTL(DFN,.DGINPUT)
 D UPDADDLG^DGADDUTL(DFN,.DGPRIOR,.DGINPUT)
 Q
INPUT(DGINPUT,DFN,FSTR,CNTRY) ;Let user input address changes
 ;Output: DGINPUT(field#)=external^internal(if any)
 N DIR,X,Y,DA,DGR,DTOUT,DUOUT,DIROUT,DGN,L
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L),DGINPUT(DGN)="" Q:DGINPUT=-1  D
 . I $$SKIP(DGN,.DGINPUT,.FLG) Q
 . I DGN=.1112 D ZIPINP(.DGINPUT,DFN) Q
 . I '$$READ(DFN,DGN,.Y) S DGINPUT=-1 Q
 . I DGN=.121 S Y=$G(Y) D  Q
 .. I Y="",DGINPUT(DGN)="" Q
 .. I $P(Y,U)=$$GET1^DIQ(2,DFN_",",DGN,"I") S DGINPUT(DGN)=$$GET1^DIQ(2,DFN_",",DGN)_U_$P(Y,U) Q
 .. S DGINPUT(DGN)=$P(Y(0),U)_U_Y
 . S DGINPUT(DGN)=$G(Y)
 I DGINPUT'=-1 S DGINPUT(.1173)=CNTRY_"^"_$O(^HL(779.004,"B",CNTRY,""))
 Q
GETOLD(DGCMP,DFN) ;populate array with existing address info
 N CCIEN,DGCURR,CFORGN,CFSTR,L,T,DGCIEN,DGST,DGCNTY,COUNTRY
 S CFORGN=0
 ; get current country
 ; If current country is NULL it is old data
 ; Leave it NULL here because this is not an edit funtion
 S CCIEN=$$GET1^DIQ(2,DFN_",","COUNTRY","I")
 ;I CCIEN="" S CCIEN=$O(^HL(779.004,"D","UNITED STATES",""))
 S CFORGN=$$FORIEN^DGADDUTL(CCIEN)
 ;get current address fields and xlate to ^DIQ format
 S CFSTR=$$INPT1(DFN,CFORGN),CFSTR=$TR(CFSTR,",",";")
 ; Domestic data needs some extra fields
 I 'CFORGN S CFSTR=CFSTR_";.114;.115;.117"
 D GETS^DIQ(2,DFN_",",CFSTR,"EI","DGCURR")
 F L=1:1:$L(CFSTR,";") S T=$P(CFSTR,";",L),DGCMP("OLD",T)=$G(DGCURR(2,DFN_",",T,"E"))
 S COUNTRY=$$CNTRYI^DGADDUTL(CCIEN) I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
 S DGCMP("OLD",.1173)=COUNTRY_"^"_CCIEN
 I 'CFORGN D
 . S DGCIEN=$G(DGCURR(2,DFN_",",.117,"I"))
 . S DGST=$G(DGCURR(2,DFN_",",.115,"I"))
 . S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN)
 . I DGCNTY=-1 S DGCNTY=""
 . S DGCMP("OLD",.117)=$P(DGCNTY,U)_" "_$P(DGCNTY,U,3)
 Q
 ;
COMPARE(DGINPUT,DGCMP,FLG) ;Display before & after address fields.
 N DGM
 M DGCMP("NEW")=DGINPUT
 F DGM="OLD","NEW" D
 . I DGCMP(DGM,.1173)]"",$$FORIEN^DGADDUTL($P(DGCMP(DGM,.1173),U,2)) D DISPFGN(.DGCMP,DGM,.FLG) Q
 . I DGM="NEW" D
 . . S DGCNTY=$P($G(DGCMP("NEW",.117)),U)_" "_$P($G(DGCMP("NEW",.117)),U,3)
 . . S DGCMP("NEW",.117)=DGCNTY
 . . I ($L(DGCMP("NEW",.1112))>5)&($P(DGCMP("NEW",.1112),"-",2)="") S DGCMP("NEW",.1112)=$E(DGCMP("NEW",.1112),1,5)_"-"_$E(DGCMP("NEW",.1112),6,9)
 . D DISPUS(.DGCMP,DGM,.FLG)
 Q
 ;
DISPUS(DGCMP,DGM,FLG) ;tag to display US data
 N DGCNTRY
 W !,?2,"[",DGM," ADDRESS]"
 W ?16,$P($G(DGCMP(DGM,.111)),U)
 I $P($G(DGCMP(DGM,.112)),U)'="" W !,?16,$P($G(DGCMP(DGM,.112)),U)
 I $P($G(DGCMP(DGM,.113)),U)'="" W !,?16,$P($G(DGCMP(DGM,.113)),U)
 W !,?16,$P($G(DGCMP(DGM,.114)),U)
 W:($P($G(DGCMP(DGM,.114)),U)'="")!($P($G(DGCMP(DGM,.115)),U)'="") ","
 W $P($G(DGCMP(DGM,.115)),U)
 W " ",$G(DGCMP(DGM,.1112))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.1173)),U,2))
 I DGCNTRY]"",(DGCNTRY'=-1) W !?16,DGCNTRY
 I $P($G(DGCMP(DGM,.117)),U)'="" W !,?6,"  County: ",$P($G(DGCMP(DGM,.117)),U)
 I $G(FLG(1))=1 D
 . W !,?6,"   Phone: ",?16,$P($G(DGCMP(DGM,.131)),U)
 . W !,?6,"  Office: ",?16,$P($G(DGCMP(DGM,.132)),U)
 W !,?6,"Bad Addr: ",?16,$P($G(DGCMP(DGM,.121)),U)
 W !
 Q
 ;
DISPFGN(DGCMP,DGM,FLG) ;tag to display Foreign data
 N DGCNTRY
 W !,?2,"[",DGM," ADDRESS]"
 W ?16,$P($G(DGCMP(DGM,.111)),U)
 I $P($G(DGCMP(DGM,.112)),U)'="" W !,?16,$P($G(DGCMP(DGM,.112)),U)
 I $P($G(DGCMP(DGM,.113)),U)'="" W !,?16,$P($G(DGCMP(DGM,.113)),U)
 W !,?16,$P($G(DGCMP(DGM,.1172)),U)_" "_$P($G(DGCMP(DGM,.114)),U)_" "_$P($G(DGCMP(DGM,.1171)),U)
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.1173)),U,2))
 S DGCNTRY=$S(DGCNTRY="":"UNSPECIFIED COUNTRY",DGCNTRY=-1:"UNKNOWN COUNTRY",1:DGCNTRY)
 I DGCNTRY]"" W !?16,DGCNTRY
 I $G(FLG(1))=1 D
 . W !,?6,"   Phone: ",?16,$P($G(DGCMP(DGM,.131)),U)
 . W !,?6,"  Office: ",?16,$P($G(DGCMP(DGM,.132)),U)
 W !,?6,"Bad Addr: ",?16,$P($G(DGCMP(DGM,.121)),U)
 W !
 Q
 ;
CONFIRM() ;Confirm if user wants to save the change
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 S DIR(0)="Y"
 S DIR("A")="Are you sure that you want to save the above changes"
 S DIR("?")="Please answer Y for YES or N for NO."
 D ^DIR
 I $D(DTOUT)!($G(Y)=0) Q 0
 I $D(DUOUT)!$D(DIROUT) Q 0
 Q 1
SAVE(DGINPUT,DFN,FSTR,FORGN) ;Save changes
 N DGN,DGER,DGM,L
 S DGER=0
 ; need to get the country code into the DGINPUT array
 ; if it's a domestic address, we have to add in CITY,STATE & COUNTY
 S FSTR=FSTR_$S('FORGN:",.114,.115,.117,.1173",1:",.1173")
 F L=1:1:$L(FSTR,",") S DGN=$P(FSTR,",",L) D
 . I ($G(FLG(1))'=1)&((DGN=.131)!(DGN=.132)) Q
 . N DGCODE,DGNAME,FDA,MSG
 . S DGCODE=$P($G(DGINPUT(DGN)),U,2)
 . S DGNAME=$P($G(DGINPUT(DGN)),U)
 . S FDA(2,DFN_",",DGN)=$S(DGCODE:DGCODE,1:DGNAME)
 . D FILE^DIE($S(DGCODE:"",1:"E"),"FDA","MSG")
 . I $D(MSG) D
 .. S DGM="",DGER=1
 .. W !,"Please review the saved changes!!",!
 .. F  S DGM=$O(MSG("DIERR",1,"TEXT",DGM)) Q:DGM=""  D
 ... W $G(MSG("DIERR",1,"TEXT",DGM))
 I $G(DGER)=0 W !,"Change saved."
 D EOP
 Q
READ(DFN,DGN,Y) ;Read input, return success
 N SUCCESS,DIR,DA,DTOUT,DUOUT,DIROUT,L,POP
 S SUCCESS=1,POP=0
 F L=0:0 D  Q:POP
 . S DIR(0)=2_","_DGN
 . S DA=DFN
 . D ^DIR
 . I $D(DTOUT) S POP=1,SUCCESS=0 Q
 . I $D(DUOUT)!$D(DIROUT) D UPCT Q
 . S POP=1
 Q SUCCESS
INPT1(DFN,FORGN,PSTR) ; first address input prompts
 N FSTR
 ; PSTR is the full set of fields domestic & foreign combined
 ; FSTR is the set of fields depending on Country code
 S PSTR=".111,.112,.113,.114,.115,.117,.1112,.1171,.1172,.1173,.131,.132,.121"
 S FSTR=".111,.112,.113,.1112,.131,.132,.121"
 I FORGN S FSTR=".111,.112,.113,.114,.1171,.1172,.131,.132,.121"
 Q FSTR
ZIPINP(DGINPUT,DFN) ; get ZIP+4 input
 N DGR
 D EN^DGREGAZL(.DGR,DFN)
 I $G(DGR)=-1 Q
 M DGINPUT=DGR
 Q
SKIP(DGN,DGINPUT,FLG) ; determine whether or not to skip this step
 N SKIP
 S SKIP=0
 I ($G(DGINPUT(.111))="")&((DGN=.112)!(DGN=.113)) S SKIP=1
 I ($G(DGINPUT(.112))="")&(DGN=.113) S SKIP=1
 I ($G(FLG(1))'=1)&((DGN=.131)!(DGN=.132)) S SKIP=1
 Q SKIP
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 Q
UPCT ;Indicate "^" or "^^" are unacceptable inputs.
 W !,"EXIT NOT ALLOWED ??"
 Q
