RMPRHL7B ;HINES/HNC - Process order parameters set file 668 ;3-21-00
 ;;3.0;PROSTHETICS;**45,52,62,78**;Feb 09, 1996
 ;
 ; ODJ - patch 52 - 10/13/00 - remove leading blank lines from
 ;                             consult text
 ; RVD - patch 62 - update ICD9 field from the HL7 message.
 ; TH  - patch 78 - 09/26/03 - update ICD9 codes, value for each SC and 
 ;                             EI. 
 ;
NEW ;Create new suspense
 ;
 ;RMPRO=^RMPR(668,IFN, the new file number in file ^RMPR(668,
 ;RMPRORFN=OE/RR file number (pointer to Order file)
 ;RMPRWARD=ward patient is on
 ;RMPRSS=type of consult
 ;RMPRAD=date/time of request
 ;RMPRPRI=procedure/request       
 ;RMPRURGI=urgency POINTER 101 TO FREE T
 ;RMPRORNP=patient's ordering provider
 ;RMPRTYPE=request type (request or consult)
 ;RMPRSBR=service rendered on what basis (Inpatient, or Outpatient)
 ;RMPRRFQ=reason for request array - word processing fields
 ;RMPRPRDG=provisional DX
 ;RMPRPRCD=provisional DX code
 ;
 ;
 ;next 4 lines added by patch #62
 S RMPRIECD=""
 I $D(RMPRPRCD),RMPRPRCD'="" D
 .S RMPRIECD=$O(^ICD9("BA",RMPRPRCD,0))
 .I '$G(RMPRIECD) S RMPRIECD=$O(^ICD9("BA",RMPRPRCD_" ",0))
 ; next 5 lines added by patch #78
 ; override previous Provisional Diagnosis code with first BA code
 I $D(RMPRMSG1(1,1)) S RMPRPRCD=$$GET1^DIQ(80,RMPRMSG1(1,1)_",",.01),RMPRIECD=RMPRMSG1(1,1)
 I '$G(RMPRIECD) D
 . N RMLP F RMLP=2:1:4 I $D(RMPRMSG1(RMLP,1)) S RMPRPRCD=$$GET1^DIQ(RMPRMSG1(RMLP,1)_",",.01),RMPRIECD=RMPRMSG1(RMLP,1) Q
 ;
 N DIC,DLAYGO,X,DR,DIE
 S DIC="^RMPR(668,",DIC(0)="L",X="""N""",DLAYGO=668 D ^DIC K DLAYGO Q:Y<1
 S (DA,RMPRO)=+Y,DIE=DIC
 ;
 L +^RMPR(668,RMPRO)
 ; .01-Suspense date;22-Date RX written
 S DR=".01////^S X=RMPRAD;22////^S X=RMPRAD"
 ; 1-Veteran;19-CPRS order #;2-station;9-Type or request;2.3-Urgency
 ; 30-Consult Visit#
 S DR=DR_";1////^S X=DFN;19////^S X=RMPRORFN;2////^S X=RMPRFAC;9////^S X=RMPRSS;2.3////^S X=RMPRURGI;30////^S X=VISIT"
 D ^DIE
 ;
 ; 8-Suspense by (ordering provider);14-Status (O=Open);
 ; 3-Suspense form (9=for other);13-Requestor (ordering provider)
 ; 1.5-Provisional Diagnosis;1.6-ICD9
 S DR="8////^S X=RMPRORNP;14////^S X=""O"";3////^S X=9;13////^S X=RMPRORNP;1.5////^S X=$G(RMPRPRDG);1.6////^S X=$G(RMPRIECD)"
 D ^DIE
 ;
 ; Patch 78: Update ICD9 and value of each SC and EI.
 S RMPRMAX=8  ; ao - cv
 F RMPRI=1:1:99 Q:'$D(RMPRMSG1(RMPRI))  S DR="" D
 . F RMPRJ=1:1:RMPRMAX S RMVALUE=$G(RMPRMSG1(RMPRI,RMPRJ)) D
 . . S DR=DR_"3"_(RMPRI-1)_$S(RMPRJ>1:"."_(RMPRJ-1),1:"")_"////^S X="
 . . S DR=DR_$S(RMVALUE="":"""""",1:RMVALUE)_$S(RMPRJ<RMPRMAX:";",1:"")
 . . D ^DIE
 ; following lines deleted by WLC 05/24/04
 ; New BA Phase II modifications for multiples
 ;S RMPRMAX=8
 ;F RMPRI=1:1:99 Q:'$D(RMPRMSG1(RMPRI))  K FDA D
 ;. S FDA(668.02,"+"_RMPRI_","_RMPRO_",",.01)=RMPRMSG1(RMPRI,1)
 ;. F RMPRJ=2:1:RMPRMAX S RMVALUE=$G(RMPRMSG1(RMPRI,RMPRJ)) D
 ;. . S FDA(668.02,"+"_RMPRI_","_RMPRO_",","30."_RMPRJ)=RMVALUE
 ;. S DIE=668.02
 ;. D UPDATE^DIE(,"FDA") I $D(^TMP("DIERR",$J))
 ;K FDA
 ;
 I $O(RMPRRFQ(0)) D REASON
 L -^RMPR(668,RMPRO)
 ;
 D REASON
 D EXIT
 Q
REASON ;load the reason for request into description of item field 4
 ;^RMPR(668,D0,2,D1,0)
 ;
 N RMPRC
 S ^RMPR(668,RMPRO,2,0)="^^^"_$S($D(RMPRDA):RMPRDA,1:DT)_"^"
 S RMPRL=0,RMPRLN=0
 F  S RMPRL=$O(RMPRRFQ(RMPRL)) Q:RMPRL=""  D
 . I 'RMPRLN D  Q:RMPRC=""  ;strip leading space from 1st line, ignore blank line
 .. S RMPRC=$E($TR(RMPRRFQ(RMPRL)," ","")) ;1st non space char
 .. S:RMPRC'="" RMPRRFQ(RMPRL)=$E(RMPRRFQ(RMPRL),$F(RMPRRFQ(RMPRL),RMPRC)-1,$L(RMPRRFQ(RMPRL))) ;extract from 1st non space char to end of line
 .. Q
 . S RMPRLN=RMPRLN+1,^RMPR(668,RMPRO,2,RMPRLN,0)=RMPRRFQ(RMPRL)
 . Q
 S $P(^RMPR(668,RMPRO,2,0),"^",3)=RMPRLN
 K RMPRL,RMPRLN
 Q
 ;
EXIT ;common exit
 K DA,DIC,DIE,DR,RMPRORTX
 K RMPRI,RMPRJ,RMPRMAX,RMVALUE,RMPRMSG1,RMPRPRCD,RMPRIECD
 Q
 ;END
