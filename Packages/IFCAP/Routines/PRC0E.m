PRC0E ;WISC/PLT-FMS Document Inquiry Utility ;12/16/94  12:50
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;PRCA data ^1=txn type:description;txn type...,^2=select document text (see Q3)
 ;           ^2=select document text (see Q3), ^status codes (option)
 ;PRCB=executed mumps codes
 ; with X given data ^1=station, ^2=txn type, ^3=document id, ^4=file 2100.1 record id
EN(PRCA,PRCB) ;Display FMS document
 N PRC,PRCRI,PRCID,PRCTX,PRCF,PRCPT
 N GECSDATA
 S PRCPT=$S($P(PRCA,"^",2)]"":$P(PRCA,"^",2),1:"Obligation/Common Number: ")
Q1 S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT
Q2 ;
 D SC^PRC0A(.X,.Y,"Select Transaction Type","OM^"_$P(PRCA,"^"),"")
 G:Y=""!(X="")!(X["^") EXIT
 S PRCTX=Y
 K X,Y
Q3 ;
 D EN^DDIOL(" ")
 S X=$$SELECT^GECSSTAA(PRCTX,PRC("SITE"),$TR($P(PRCA,"^",3),"~","^"),"",$P(PRCA,"^",2))
 I $D(DTOUT)!$D(DUOUT) K DTOUT,DUOUT G EXIT
 G:'X Q2
 S X=$P(X,U,2)
 D DATA^GECSSGET(X,0)
 I '$G(GECSDATA) D EN^DDIOL(PRCPT_" NOT found!") G Q3
 S PRCRI(2100.1)=GECSDATA,PRCID=GECSDATA(2100.1,PRCRI(2100.1),.01,"E")
 D EN^DDIOL(" "),EN^DDIOL($J("FMS Document: ",15)_PRCID)
 D EN^DDIOL($J("Description: ",15)_GECSDATA(2100.1,PRCRI(2100.1),4,"E"))
 D EN^DDIOL($J("Status: ",15)_GECSDATA(2100.1,PRCRI(2100.1),3,"E"))
 D EN^DDIOL($J("Created: ",15)_GECSDATA(2100.1,PRCRI(2100.1),2,"E"))
 S X=PRC("SITE")_"^"_PRCTX_"^"_PRCID_"^"_PRCRI(2100.1)
 ;RESERVED FOR ERROR MESSAGE DISPLAY
 I $G(PRCB)]"" S Y=PRCB D
 . N PRCA,PRCB,PRC,PRCRI,PRCID,PRCTX,PRCF,PRCPT
 . X Y
 K GECSDATA,X,Y
 G Q3
 ;
EXIT K X,Y
 QUIT
 ;
 ; If this is a prior year transaction, ask if it should be an SO or AR
 ; PATDA = ien for document being processed
 ; PRCFATT = SO or AR
 ; PRCMSG = Flag indicating what prompt to use
SOAR(PATDA,PRCFATT,PRCMSG) N PRCFCFY,PRCFY,PRCFX,PRCFZ,PRCMSGT,SD
 S SD=$G(^PRC(411,"A IFCAP-Wide Parameters","SO 2 AR Date")) ;  FMS accrual date
 S PRCFCFY=$E(DT,1,3)+1700 ; CURRENT YEAR
 ; calculate the effective FMS fiscal year
 I $E(DT,4)=1 S PRCFCFY=PRCFCFY+$S(SD>0:DT>SD,1:1) ; if OCT,NOV,DEC, increment year if today is after the FMS accrual date
 S PRCFY="",PRCFX=0
 ; get acctg pd/oblig date for the first SO.E transaction on this record
 F  S PRCFX=$O(^PRC(442,PATDA,10,PRCFX)) Q:+PRCFX'=PRCFX  S PRCFZ=$G(^PRC(442,PATDA,10,PRCFX,0)) I $P($P(PRCFZ,U),".",1,2)="SO.E" D  Q
 . S PRCFY=$S($P(PRCFZ,U,13)]"":$P(PRCFZ,U,13),1:$P(PRCFZ,U,12))
 . S PRCFY=$E(PRCFY,1,3)+1700+$E(PRCFY,4)
 S PRCFX=1 ; flag to assume document is prior year
 I PRCFCFY'>PRCFY S PRCFX=0 ; document will not require AR/SO calculation (either after 10/1 & before FMS accrual date or doc is current fiscal year)
 I PRCFX=0,PRCFCFY=PRCFY,DT'>SD,$E(DT,4)=1 G SOARA ; force user to be prompted if document is prior year (after 10/1 but not after FMS accrual date)
 I PRCFX=0 G SOARQ1 ; do not prompt user for this document
 ;
 ; calculate whether AR or SO should be used
 I PRCFX=1,$P($G(^PRC(442,PATDA,23)),U,6)'=0 S PRCFATT="AR" ; set txn type to AR if auto accrue flag is yes
 ;
 ; ask user
SOARA S PRCMSGT=$S(PRCMSG=1:"SEND TO FMS AS AN: ",PRCMSG=2:"POST AGAINST AN FMS: ")
 D SC^PRC0A("",.Y,PRCMSGT,"AOM^AR:RECEIVER ACCRUAL DOCUMENT;SO:SERVICE ORDER DOCUMENT",PRCFATT)
 S PRCFATT=$P(Y,":",1)
SOARQ K Y
SOARQ1 Q
