DGREGCP1 ;ALB/CLT,ARF,JAM - ADDRESS COPY UTILITIES ; 18 May 2017  2:54 PM
 ;;5.3;Registration;**941,1010,1040,1056,1143**;Aug 13, 1993;Build 36
 ;
RESDISP(DFN) ;DISPLAY THE RESIDENTIAL ADDRESS
 N DGA1,DGA2,DGA3,DGA4,DGA9,DGA10,DGA1315,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 ;DG*5.3*1056 remove Permanent from the message following displayed message
 W !,"Residential Address to copy to the Mailing Address:",!
 I $G(^DPT(DFN,.115))="" D  Q
 .W !?5,"NO RESIDENTIAL ADDRESS"
 ;DISPLAY THE CURRENT RESIDENTIAL ADDRESS
 S DGXX=^DPT(DFN,.115),DGA1=$P(DGXX,"^",1),DGA2=$P(DGXX,"^",2),DGA3=$P(DGXX,"^",3),DGA4=$P(DGXX,"^",4)
 S DGA9=$P(DGXX,"^",9)
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORDISP ;DISPLAY FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . I $P(DGXX,U,5)=""!($P(DGXX,U,7)="") W "UNKNOWN" Q
 . I $P(DGXX,U,7)'="" I $D(^DIC(5,$P(DGXX,U,5),1,$P(DGXX,U,7),0)) D
 .. S DGST=$P(DGXX,U,5),DGCIEN=$P(DGXX,U,7)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($P(DGXX,U,8)'="":$P(DGXX,U,8),1:"UNKNOWN")
 ;I DGFORGN W !?3,DGA9_" "_DGA4 ;DG*1010 comment out
 I DGFORGN W !?3,DGA4_" "_DGA9 ;DG*1010 - display postal code last
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$P(^DPT(DFN,.115),"^",5),0)) W ",",$P(^DIC(5,+$P(^DPT(DFN,.115),"^",5),0),"^",2)
 . S DGZIP=$P(^DPT(DFN,.115),"^",6) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
 ;
PERMDISP(DFN) ;DISPLAY MAILING ADDRESS
 N DGA1,DGA9,DGA10,DGA1315,DGA2,DGA3,DGA4,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 ;DG*5.3*1056 remove Permanent from the message following display messages and comment
 W !,"Mailing Address to copy to Residential Address:",!
 I $G(^DPT(DFN,.11))="" D  Q
 .W !?5,"NO MAILING ADDRESS"
 ;DISPLAY THE CURRENT MAILING ADDRESS
 S DGXX=^DPT(DFN,.11),DGA1=$P(DGXX,"^",1),DGA2=$P(DGXX,"^",2),DGA3=$P(DGXX,"^",3),DGA4=$P(DGXX,"^",4)
 S DGA9=$P(DGXX,"^",9)
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORGNCHK ;CHECK FOR FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . I $P(DGXX,U,5)=""!($P(DGXX,U,7)="") W "UNKNOWN" Q
 . I $P(DGXX,U,7)'="" I $D(^DIC(5,$P(DGXX,U,5),1,$P(DGXX,U,7),0)) D
 .. S DGST=$P(DGXX,U,5),DGCIEN=$P(DGXX,U,7)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($P(DGXX,U,8)'="":$P(DGXX,U,8),1:"UNKNOWN")
 ;I DGFORGN W !?3,DGA9_" "_DGA4 ;DG*1010 comment out
 I DGFORGN W !?3,DGA4_" "_DGA9 ;DG*1010 - display postal code last
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$P(^DPT(DFN,.11),"^",5),0)) W ",",$P(^DIC(5,+$P(^DPT(DFN,.11),"^",5),0),"^",2)
 . S DGZIP=$P(^DPT(DFN,.11),"^",12) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
 ;
RESMVQ(DFN) ;DISPLAY RESIDENTIAL ADDRESS AND QUESTION IF COPY TO PERM IS DESIRED
 ; If Real-time address updates are active, copy using local arrays holding the data
 I $G(DGRTAON)=1 D RESMVQRTA(DFN) Q
 ;
 I $G(^DPT(DFN,.115))="" Q
 N DIR,X,Y,DTOUT,DUOUT
 ;DG*5.3*1056 remove Permanent from the message following displayed prompts
 S DIR(0)="Y",DIR("A")="Copy the Residential Address to the Mailing Address",DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' to copy the Residential Address ",DIR("?")="to the Mailing Address."
 D ^DIR
 ; DG*5.3*1040 - Check for timeout of the Copy prompt
 I $D(DTOUT) S DGTMOT=1 Q
 I $G(Y)=1 D
 . W !
 . D RESDISP(DFN)
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . S DIR("?",1)="If you answer 'YES' the current Residential Address will be copied",DIR("?")="to the Permanent Mailing Address."
 . D ^DIR
 . ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 . I $D(DTOUT) S DGTMOT=1 Q
 . ; DG*5.3*1040 - QUIT if variable Y = 0
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D R2P^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 Q
 ;
PERMMVQ(DFN) ;DISPLAY MAILING ADDRESS AND QUESTION IF COPY TO RESIDENTIAL IS DESIRED
 ; If Real-time address updates are active, copy using local arrays holding the data
 I $G(DGRTAON)=1 D PERMMVQRTA(DFN) Q
 ;
 ; First check for a valid Mailing Address that can be copied to residential address
 N DGXX,DGA10,DFORGN
 S DGXX=$G(^DPT(DFN,.11))
 ; Quit if nothing in Perm address line 1 field
 I $P(DGXX,"^",1)="" Q
 ; Quit if nothing in Perm address City field
 I $P(DGXX,"^",4)="" Q
 ; Quit if no Perm address zip code defined for a domestic address
 S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 S DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I 'DGFORGN&($P(DGXX,"^",6)="") Q
 ; required address fields exist for copying to Residential address
 ; now check for PO Box or General Delivery and notify user if not valid for residential address and quit
 ; DG*5.3*1143 - Collect line 1 and state
 N DGADD,DIR,X,Y,DGRESADD,DGRESX,DGA5,DGLINE1
 K DIRUT
 S DGLINE1=$P(DGXX,"^",1),DGA5=$P(DGXX,"^",5)
 ; DG*5.3*1143 - Pass line 1, state and country to function
 I $$POBOXPM^DGREGCP2(DGLINE1,DGA5,DGA10) D  Q
 . W !!?3,*7,"P.O. Box and GENERAL DELIVERY cannot be used in residential address." W !
 . ;DG*5.3*1056 remove Permanent from the following message displayed messages
 . W !,"Because the Mailing Address line 1 contains P.O. Box"
 . W " or General",!,"Delivery the Mailing Address cannot be copied to"
 . W !,"the Residential Address."
 . D EOP
 . ; DG*5.3*1040 - Check for timeout
 . Q:+$G(DGTMOT)
 ; Perm address is valid for use as a Residential address
ASK ; 
 W !
 ;DG*5.3*1056 remove Permanent from the following message displayed message and prompt
 S DIR(0)="Y",DIR("A")="Copy the Mailing Address to the Residential Address"
 S DIR("?",1)="Answer 'YES' or 'NO'. 'YES' will copy the current Mailing Address",DIR("?")="to the Residential Address."
 S DIR("B")="NO"
 D ^DIR
 I X="Y"!(X="YES") S Y=1,Y(0)="YES"
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 I $D(DTOUT) S DGTMOT=1 Q
 ; DG*5.3*1040 - QUIT if Y = 0
 Q:$G(Y)=0
 I $D(DUOUT)!$D(DIROUT) Q
 I $D(DIRUT) G ASK
 I Y=1 D
 . W !
 . D PERMDISP(DFN) ;; W !! D RESDISP(DFN) W !
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . ;DG*5.3*1056 remove Permanent from the following message displayed prompt
 . S DIR("?",1)="If you answer 'YES' the current Mailing Address will be copied",DIR("?")="to the Residential Address."
 . D ^DIR
 . ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 . I $D(DTOUT) S DGTMOT=1 Q
 . ; DG*5.3*1040 - QUIT if Y = 0
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D P2R^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 ; DG*5.3*1040 - Check for timeout
 Q:+$G(DGTMOT)
 Q
EOP ;End of page prompt
 N DIR,DTOUT,DUOUT,DIROUT,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1 to track timeout
 I $D(DTOUT) S DGTMOT=1 Q
 Q
 ;
 ; DG*5.3*1043 - Copy operation for Real-time address update 
RESMVQRTA(DFN) ;DISPLAY RESIDENTIAL ADDRESS AND QUESTION IF COPY TO PERM IS DESIRED
 ; If both the local array and database LINE1 fields for Residential address are not defined, quit
 I $G(DGADDGRP1(.1151))=""&($P($G(^DPT(DFN,.115)),"^",1)="") Q
 N DIR,X,Y,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Copy the Residential Address to the Mailing Address",DIR("B")="NO"
 S DIR("?",1)="Enter 'YES' to copy the Residential Address ",DIR("?")="to the Mailing Address."
 D ^DIR
 K DIR
 I $D(DTOUT) S DGTMOT=1 Q
 I $G(Y)=1 D
 . W !
 . ; If local array not defined, display address from the database fields, otherwise display using local array
 . I $G(DGADDGRP1(.1151))="" D RESDISP(DFN)
 . E  D RESDISPRTA(DFN)
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . S DIR("?",1)="If you answer 'YES' the current Residential Address will be copied",DIR("?")="to the Permanent Mailing Address."
 . D ^DIR
 . I $D(DTOUT) S DGTMOT=1 Q
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D R2PLOCAL^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 Q
 ;
RESDISPRTA(DFN) ;DG*5.3*1043 - Residential address display operation for Real-time address update
 N DGA1,DGA2,DGA3,DGA4,DGA9,DGA10,DGA1315,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 W !,"Residential Address to copy to the Mailing Address:",!
 ;DISPLAY THE CURRENT RESIDENTIAL ADDRESS FROM THE LOCAL ARRAY DGADDGRP1
 S DGA1=DGADDGRP1(.1151),DGA2=DGADDGRP1(.1152),DGA3=DGADDGRP1(.1153),DGA4=DGADDGRP1(.1154)
 ; Postal Code
 S DGA9=$G(DGADDGRP1(.11572))
 S DGA10=$G(DGADDGRP1(.11573)) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORDISP ;DISPLAY FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . ; Check for State and County
 . I $G(DGADDGRP1(.1155))=""!($G(DGADDGRP1(.1157))="") W "UNKNOWN" Q
 . I $G(DGADDGRP1(.1157))'="" I $D(^DIC(5,$G(DGADDGRP1(.1155)),1,DGADDGRP1(.1157),0)) D
 .. S DGST=DGADDGRP1(.1155),DGCIEN=DGADDGRP1(.1157)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($G(DGADDGRP1(.11571))'="":DGADDGRP1(.11571),1:"UNKNOWN")
 I DGFORGN W !?3,DGA4_" "_DGA9
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,DGADDGRP1(.1155),0)) W ",",$P(^DIC(5,DGADDGRP1(.1155),0),"^",2)
 . S DGZIP=$G(DGADDGRP1(.1156)) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
 ;
 ; DG*5.3*1043 - Copy operation for Real-time address update 
PERMMVQRTA(DFN) ;DISPLAY MAILING ADDRESS AND QUESTION IF COPY TO RESIDENTIAL IS DESIRED
 ; If both the local array line 1 and database line 1 field for Mailing address are not defined, quit
 I $G(DGADDGRP2(.111))=""&($P($G(^DPT(DFN,.11)),"^",1)="") Q
 ;
 N DGA10,DGA1,DGA5,DFORGN
 ; If local array defined, get fields
 I $G(DGADDGRP2(.111))'="" D
 .; Get Country, Address Line 1 and State
 .S DGA10=$G(DGADDGRP2(.1173)) S:'DGA10 DGA10=""
 .S DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 .S DGA1=DGADDGRP2(.111)
 .S DGA5=$G(DGADDGRP2(.115))
 ;
 ; If local array does not exist, get address data from the DB
 I $G(DGADDGRP2(.111))="" D
 .N DGXX
 .S DGXX=$G(^DPT(DFN,.11))
 .; Get Country, Address Line 1 and State
 .S DGA10=$P(DGXX,"^",10) S:'DGA10 DGA10=""
 .S DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 .S DGA1=$P(DGXX,"^",1)
 .S DGA5=$P(DGXX,"^",5)
 ;
 ; Check for PO Box or General Delivery - notify user if not valid for residential address and quit
 I $$POBOXPM^DGREGCP2(DGA1,DGA5,DGA10) D  Q
 . W !!?3,*7,"P.O. Box and GENERAL DELIVERY cannot be used in residential address." W !
 . W !,"Because the Mailing Address line 1 contains P.O. Box"
 . W " or General",!,"Delivery the Mailing Address cannot be copied to the Residential Address."
 . D EOP
 ;
 ; Mailing address is valid for use as a Residential address
RTAASK ;
 N DIR,X,Y,DTOUT,DUOUT
 S DIR(0)="Y",DIR("A")="Copy the Mailing Address to the Residential Address"
 S DIR("?",1)="Answer 'YES' or 'NO'. 'YES' will copy the current Mailing Address",DIR("?")="to the Residential Address."
 S DIR("B")="NO"
 D ^DIR
 K DIR
 I X="Y"!(X="YES") S Y=1,Y(0)="YES"
 I $D(DTOUT) S DGTMOT=1 Q
 Q:$G(Y)=0
 I $D(DUOUT)!$D(DIROUT) Q
 I $D(DIRUT) G RTAASK
 I Y=1 D
 . W !
 . ; If local array not defined, display address from the database fields, otherwise display using local array
 . I $G(DGADDGRP2(.111))="" D PERMDISP(DFN)
 . I $G(DGADDGRP2(.111))'="" D PERMDISPRTA(DFN)
 . S DIR(0)="Y",DIR("A")="Are you sure you want to copy",DIR("B")=""
 . S DIR("?",1)="If you answer 'YES' the current Mailing Address will be copied",DIR("?")="to the Residential Address."
 . D ^DIR
 . I $D(DTOUT) S DGTMOT=1 Q
 . Q:$G(Y)=0
 . I $D(DUOUT)!$D(DIROUT) Q
 . D P2RLOCAL^DGREGCOP(DFN)
 . W !,"Copy completed."
 . D EOP
 Q
 ;
PERMDISPRTA(DFN) ;DG*5.3*1143 - Display Mailing Address operation for Real-time address update
 N DGA1,DGA9,DGA10,DGA1315,DGA2,DGA3,DGA4,DGZIP
 N DGE,DGXX,DGFORGN,X,Y,DGCIEN,DGST,DGCNTRY,DGCNTY
 W !,"Mailing Address to copy to Residential Address:",!
 ;DISPLAY THE CURRENT MAILING ADDRESS FROM THE LOCAL ARRAY DGADDGRP2
 S DGA1=DGADDGRP2(.111),DGA2=$G(DGADDGRP2(.112)),DGA3=$G(DGADDGRP2(.113)),DGA4=$G(DGADDGRP2(.114))
 ; Postal Code
 S DGA9=$G(DGADDGRP2(.1172))
 ; Country
 S DGA10=$G(DGADDGRP2(.1173)) S:'DGA10 DGA10=""
 S DGCNTRY=$E($$CNTRYI^DGADDUTL(DGA10),1,25),DGFORGN=$$FORIEN^DGADDUTL(DGA10)
 I DGCNTRY=-1 S DGCNTRY="UNKNOWN COUNTRY"
 W:DGA1'="" !?3,DGA1 W:$G(DGA2)'="" !?3,DGA2 W:$G(DGA3)'="" !?3,DGA3
 ;FORGNCHK ;CHECK FOR FOREIGN ADDRESS
 I DGA1="" W !
 I 'DGFORGN D
 . W ?43,"County: "
 . ; Check for State and County
 . I $G(DGADDGRP2(.115))=""!($G(DGADDGRP2(.117))="") W "UNKNOWN" Q
 . I $G(DGADDGRP2(.117))'="" I $D(^DIC(5,$G(DGADDGRP2(.115)),1,DGADDGRP2(.117),0)) D
 .. S DGST=$G(DGADDGRP2(.115)),DGCIEN=DGADDGRP2(.117)
 .. S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN) W $P(DGCNTY,"^",1),"(",$P(DGCNTY,"^",3),")"
 E  D
 . W ?43,"Province: "
 . W $S($G(DGADDGRP2(.1171))'="":$G(DGADDGRP2(.1171)),1:"UNKNOWN")
 ;I DGFORGN W !?3,DGA9_" "_DGA4 ;DG*1010 comment out
 I DGFORGN W !?3,DGA4_" "_DGA9 ;DG*1010 - display postal code last
 I 'DGFORGN W !?3,DGA4 D
 . I $D(^DIC(5,+$G(DGADDGRP2(.115)),0)) W ",",$P(^DIC(5,+DGADDGRP2(.115),0),"^",2)
 . S DGZIP=$G(DGADDGRP2(.1112)) I $L(DGZIP)>5 S DGZIP=$E(DGZIP,1,5)_"-"_$E(DGZIP,6,12)
 . W "  ",DGZIP
 W !?3,DGCNTRY,!
 Q
