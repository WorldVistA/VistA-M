VAFHLZE1 ;BPFO/JRP,TDM,JLS,KUM - Data extractor for ZEL segment ;5/24/06 3:43pm
 ;;5.3;Registration;**342,497,602,672,653,909,952,1018,1090**;Aug 13,1993;Build 16
 ;
GETDATA ;Get information needed to build ZEL  segment
 ;Input: Existence of the following variables is assumed
 ;   DFN - Pointer to Patient (#2) file
 ;   VAFPELIG - Primary Eligibility string (.36 node)
 ;   VAFSTR - Fields to extract (padded with commas)
 ;   VAFNODE - Eligibility Node (node from Elig. ["E"] mult)
 ;   VAFMSTDT - Date to use when getting MST status (optional)
 ;   VAFSETID - Value to use for Set ID (optional)
 ;   HL7 encoding characters (HLFS, HLENC, HLQ)
 ;
 ;Output: VAFHLZEL(SeqNum) = Value
 ;
 ;Notes: VAFHLZEL is initialized (KILLed) on entry
 ;     : If not passed, sequence 1 (Set ID) will have a value of '1'
 ;       if getting data for the primary eligibility and '2' if getting
 ;       data for other eligibility
 ;     : All requested fields will be returned with the primary
 ;       eligibility.  The Set ID (seq 1), eligibility code (seq 2)
 ;       long ID (seq 3), and short ID (seq 4) will be the only fields
 ;       returned for all other eligibilities.
 ;
 N IEN33,ISOTH,J,PRIME,VAF,VAFMST,X
 K VAFHLZEL
 ;If true, primary eligibility (return all fields)
 S PRIME=+VAFNODE=+VAFPELIG
 ;Set ID
 I VAFSTR[",1," S VAFHLZEL(1)=$S($G(VAFSETID):VAFSETID,PRIME:1,1:2)
 ;Eligibility Code
 I VAFSTR[",2," S X=$P($G(^DIC(8,+VAFNODE,0)),"^",9),VAFHLZEL(2)=$S(X]"":X,1:HLQ)
 ;Long ID
 I VAFSTR[",3," S X=$P(VAFNODE,"^",3),VAFHLZEL(3)=$S(X]"":$$M10^HLFNC(X),1:HLQ)
 ;Short ID
 I VAFSTR[",4," S X=$P(VAFNODE,"^",4),VAFHLZEL(4)=$S(X]"":X,1:HLQ)
 ;Done if not getting primary eligibility information
 I 'PRIME D  Q
 .N Y,Z
 .S Y=$L(VAFSTR,",")
 .F X=1:1:Y S Z=$P(VAFSTR,",",X) I Z S:(Z>4) VAFHLZEL(Z)=HLQ
 ;Get needed nodes in Patient file (#2)
 N VAF
 F X=.3,.31,.321,.3217,.322,.362,.361 S VAF(X)=$G(^DPT(DFN,X))
 ;Military Disability Retirement
 I VAFSTR[",5," S X=$P(VAFPELIG,"^",12),VAFHLZEL(5)=$S(X=0:"N",X=1:"Y",1:HLQ)
 ;Claim Number
 I VAFSTR[",6," S X=$P(VAF(.31),"^",3),VAFHLZEL(6)=$S(X]"":X,1:HLQ)
 ;Claim Folder Loc
 I VAFSTR[",7," S X=$P(VAF(.31),"^",2),VAFHLZEL(7)=$S(X]"":X,1:HLQ)
 ;Veteran?
 I VAFSTR[",8," S X=$P($G(^DPT(DFN,"VET")),"^"),VAFHLZEL(8)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Type
 I VAFSTR[",9," S X=$P($G(^DG(391,+$P($G(^DPT(DFN,"TYPE")),"^"),0)),"^"),VAFHLZEL(9)=$S(X]"":X,1:HLQ)
 ;Elig Status
 I VAFSTR[10 S X=$P(VAF(.361),"^",1),VAFHLZEL(10)=$S(X]"":X,1:HLQ)
 ;Elig Status Date
 I VAFSTR[11 S X=$P(VAF(.361),"^",2),VAFHLZEL(11)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Elig Interim Response
 I VAFSTR[12 S X=$P(VAF(.361),"^",4),VAFHLZEL(12)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Elig Verif. Method
 I VAFSTR[13 S X=$P(VAF(.361),"^",5),VAFHLZEL(13)=$S(X]"":X,1:HLQ)
 ;Rec A&A Benefits?
 I VAFSTR[14 S X=$P(VAF(.362),"^",12),VAFHLZEL(14)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Rec Housebound Benefits?
 I VAFSTR[15 S X=$P(VAF(.362),"^",13),VAFHLZEL(15)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Rec VA Pension?
 I VAFSTR[16 S X=$P(VAF(.362),"^",14),VAFHLZEL(16)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Rec VA Disability?
 I VAFSTR[17 S X=$P(VAF(.3),"^",11),VAFHLZEL(17)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Agent Orange Expos. Indicated?
 I VAFSTR[18 S X=$P(VAF(.321),"^",2),VAFHLZEL(18)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Radiation Expos. Indicated?
 I VAFSTR[19 S X=$P(VAF(.321),"^",3),VAFHLZEL(19)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Environmental Contaminants?
 I VAFSTR[20 S X=$P(VAF(.322),"^",13),VAFHLZEL(20)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 ;Total Annual VA Check Amount
 I VAFSTR[21 S X=$P(VAF(.362),"^",20),VAFHLZEL(21)=$S(X]"":X,1:HLQ)
 ;Radiation Exposure Method
 I (VAFSTR[22) D
 .S X=$P(VAF(.321),"^",12)
 .;DG*5.3*1090 - Accommodate two digit values
 .;S:(X="")!($L(X)>1) X=HLQ
 .S:(X="")!($L(X)>2) X=HLQ
 .S:(X'=HLQ) X=$TR(X,"NTB","234")
 .S VAFHLZEL(22)=X
 ;Call MST status API
 S VAFMST=$$GETSTAT^DGMSTAPI(DFN,$G(VAFMSTDT))
 I $P(VAFMST,"^",1)<0 D  I 1
 .F J=23,24,25 I VAFSTR[J S VAFHLZEL(J)=HLQ
 E  D
 .;Current MST status
 .I VAFSTR[23 S X=$P(VAFMST,"^",2),VAFHLZEL(23)=$S(X]"":X,1:HLQ)
 .;MST status change date
 .I VAFSTR[24 S X=$P(VAFMST,"^",3),VAFHLZEL(24)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 .;Site determining MST status
 .I VAFSTR[25 S X=$P(VAFMST,"^",7) S X=$$GET1^DIQ(4,(+X)_",",99) S VAFHLZEL(25)=$S(X]"":X,1:HLQ)
 ;Agent Orange Registration Date
 I VAFSTR[26 S X=$P(VAF(.321),"^",7),VAFHLZEL(26)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Agent Orange Exam Date
 I VAFSTR[27 S X=$P(VAF(.321),"^",9),VAFHLZEL(27)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Agent Orange Registration #
 I VAFSTR[28 S X=$P(VAF(.321),"^",10),VAFHLZEL(28)=$S(X]"":X,1:HLQ)
 ;Agent Orange Exposure Location
 ;I VAFSTR[29 S X=$P(VAF(.321),"^",13),VAFHLZEL(29)=$S(X]"":X,$P(VAF(.321),U,2)="Y":"U",1:HLQ)
 ;DG*5.3*1018 - Add Blue Water Navy value 
 ;I VAFSTR[29 S X=$P(VAF(.321),"^",13),VAFHLZEL(29)=$S(",K,V,O,"[(","_X_","):X,1:HLQ)
 ;DG*5.3*1090 - Add T, L, C, G, J
 I VAFSTR[29 S X=$P(VAF(.321),"^",13),VAFHLZEL(29)=$S(",K,V,O,B,T,L,C,G,J,"[(","_X_","):X,1:HLQ)
 ;Radiation Registration Date
 I VAFSTR[30 S X=$P(VAF(.321),"^",11),VAFHLZEL(30)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Envir. Cont. Exam Date
 I VAFSTR[31 S X=$P(VAF(.322),"^",15),VAFHLZEL(31)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Envir. Cont. Registration date
 I VAFSTR[32 S X=$P(VAF(.322),"^",14),VAFHLZEL(32)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;Monetary Ben. Verify Date
 I VAFSTR[33 S X=$P(VAF(.3),"^",6),VAFHLZEL(33)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;User Enrollee Valid Through
 I VAFSTR[34 S X=$P(VAF(.361),"^",7),VAFHLZEL(34)=$S(X]"":$$HLDATE^HLFNC(X),1:HLQ)
 ;User Enrollee Site
 I VAFSTR[35 S X=$P(VAF(.361),"^",8),X=$$GET1^DIQ(4,+X,99),VAFHLZEL(35)=$S(X]"":X,1:HLQ)
 ;Combat Vet
 I (VAFSTR[37)!(VAFSTR[38) D
 .N CVET
 .S CVET=$$CVEDT^DGCV(DFN)
 .;Eligible
 .I VAFSTR[37 D
 ..S X=+CVET
 ..S:X<0 X=""
 ..S VAFHLZEL(37)=$S(X]"":$$YN^VAFHLFNC(X),1:HLQ)
 .;End Date
 .I VAFSTR[38 D
 ..S X=+$P(CVET,"^",2)
 ..S VAFHLZEL(38)=$S(X:$$HLDATE^HLFNC(X),1:HLQ)
 ;Discharge Due To Disability
 I VAFSTR[39 S X=$P(VAFPELIG,"^",13),VAFHLZEL(39)=$S(X=0:"N",X=1:"Y",1:HLQ)
 ;SHAD Indicator
 I VAFSTR[40 S X=$P(VAF(.321),"^",15),VAFHLZEL(40)=$S(X=0:"N",X=1:"Y",1:HLQ)
 ;CAMP LEJEUNE ELIGIBILITY INDICATOR DG*5.3*909 
 S X=$P(VAF(.3217),"^",1),VAFHLZEL(41)=$S(X="Y":1,X="N":0,1:HLQ)
 ;CAMP LEJEUNE ELIGIBILITY DATE REGISTERED
 I VAFSTR[42 S X=$P(VAF(.3217),"^",2),VAFHLZEL(42)=$S(X]"":$P($$HLDATE^HLFNC(X,"DT"),"^",1),1:HLQ)
 ;CAMP LEJEUNE ELIGIBILITY CHANGE SITE
 I VAFSTR[43 S X=$P(VAF(.3217),"^",3),VAFHLZEL(43)=$S(X]"":X,1:HLQ)
 ;CAMP LEJEUNE ELIGIBILITY SOURCE OF CHANGE 
 I VAFSTR[44 S X=$P(VAF(.3217),"^",4),VAFHLZEL(44)=$S(X]"":X,1:HLQ)
 S ISOTH="",IEN33=+$O(^DGOTH(33,"B",DFN,"")) I IEN33 S ISOTH=$$GET1^DIQ(33,IEN33_",",.02,"I")
 ;OTH Eligibility Indicator
 I VAFSTR[45 S VAFHLZEL(45)=$S(IEN33:ISOTH,1:"")
 ;OTH Eligibility Factor Code
 I VAFSTR[46 S VAFHLZEL(46)="" S:IEN33 X=$$GET1^DIQ(2,DFN_",",.5501,"I"),VAFHLZEL(46)=$S(X="OTH-90":1,X="OTH-EXT":2,1:"")
 ;OTH Eligibility Update Date
 I VAFSTR[47 S VAFHLZEL(47)=$S(IEN33:$$HLDATE^HLFNC($$GETTIMST^DGOTHEL(DFN)),1:"")
 ;Done
 Q
