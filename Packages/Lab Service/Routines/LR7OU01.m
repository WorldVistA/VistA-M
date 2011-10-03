LR7OU01 ;slc/dcm - Build HL7 Components ;8/11/97
 ;;5.2;LAB SERVICE;**121,187**;Sep 27, 1994
 ;
ORC(COUNT) ;ORC segment
 ;X1 = Order Control (SN-backdoor new order, OC-Cancel, SC-on collection
 ;     SC-collected, RE-completed) See table 119
 ;X2 = Lab Number
 ;X3 = Order Status (table 38)
 ;X4 = Quantity/Timing - Quantity^Interval^Duration^Start D/T^End D/T^Priority^Condition^Text^Conjunction
 ;X5 = Date ordered/entered
 ;X6 = Provider # (ptr to file 200)
 ;X7 = Order effective D/T
 ;X8 = Order Control Reason
 ;X9 = OE/RR Order #
 ;X10 = Entered by
 N ORC,CTR,ARAY
 S CTR=0,ARAY=""
 D BUILD("ORC|"),BUILD(X1_"|"_$S($L(X9):X9_"^OR",1:"")_"|"),BUILD(X2_"^||"),BUILD(X3_"||"),BUILD(X4_"||"),BUILD(X5_"|"),BUILD($$PERSON(X10)_"||")
 D BUILD($$PERSON(X6)_"|||"),BUILD(X7_"|"),BUILD(X8)
 M @MSG@(COUNT)=ARAY
 Q
OBR(COUNT) ;OBR segment
 ;COUNT=Current count for MSG array
 ;X1 = Universal ID - ^^^ifn (from file 60)^Test Name^99_SectionID
 ;     SectionID: LRT=Chem Hem Tox Micro AP, LRB=Bloodbank
 ;X2 = Observation D/T
 ;X3 = Specimen Action Code (table 65)
 ;X4 = Specimen Recieved D/T
 ;X5 = Specimen Source (table 70)
 ;X6 = Accession (Filler Field 1)
 ;X7 = Results reported or Status changed D/T
 ;X8 = Result Status (table 123)
 ;X9 = Quantity/timing
 ;X10 = Result copies to: location
 ;COBR = OBR counter
 N OBR,CTR,ARAY
 S CTR=0,ARAY=""
 D BUILD("OBR|"),BUILD(COBR_"|||"),BUILD(X1_"|||"),BUILD(X2_"||||"),BUILD(X3_"|||"),BUILD(X4_"|"),BUILD(X5_"|||||")
 D BUILD(X6_"||"),BUILD(X7_"|||"),BUILD(X8_"||"),BUILD(X9_"|"),BUILD(X10)
 M @MSG@(COUNT)=ARAY
 Q
OBX(COUNT) ;OBX Result segment
 ;X1 = Value type (table 125)
 ;X2 = Observation ID - ^^^ifn (from file 60)^Test Name^99_SectionID
 ;X3 = Observation Sub-ID
 ;X4 = Result
 ;X5 = coded per table 36
 ;X6 = Reference Range
 ;X7 = Abnormal Flag (table 78)
 ;X8 = Observ Result Status (table 85)
 ;COBX = OBX Counter
 ;X10 = User Defined Access Checks
 ;X11 = Verified by
 N OBX,CTR,ARAY
 S CTR=0,ARAY=""
 D BUILD("OBX|"_COBX_"|"),BUILD(X1_"|"),BUILD(X2_"|"),BUILD(X3_"|"),BUILD(X4_"|"),BUILD(X5_"|"),BUILD(X6_"|"),BUILD(X7_"|||"),BUILD(X8_"||"),BUILD(X10_"||"),BUILD($$PERSON(X11))
 M @MSG@(COUNT)=ARAY
 Q
NTE(ID,SOURCE,NODE,CTR) ;NTE Notes segment
 ;ID=SET ID
 ;SOURCE = Source of comment P=>Placer, L=>Filler, O=>Other system
 ;NODE=Local array with text in the form ARRAY( or ARRAY(I,
 ;CTR=Counter for 1st subscript in MSG(ctr) array
 Q:'$L(NODE)  N NTE,FIRST,SUB,X,IFN
 S NTE="NTE|"_ID_"|"_SOURCE,IFN=0,FIRST=1
 F  S IFN=$O(@(NODE_IFN_")")) Q:IFN<1  S X=@(NODE_IFN_")") D
 . I X["For Test: " Q  ;Screen out unecessary test text
 . I FIRST S @MSG@(CTR)=NTE_"|"_X S FIRST=0,SUB=0 Q
 . S SUB=SUB+1,@MSG@(CTR,SUB)=X
 Q
PERSON(X) ;Get person in external format
 I '$G(X) Q 0
 I '$D(^VA(200,+X,0)) Q X
 S X=+X_"^"_$P(^VA(200,+X,0),"^")
 Q X
BUILD(FIELD) ;Build a segment
 ;FIELD=text/field to add to segment
 ;ARAY is built until length is >244 characters then
 ;ARAY(ifn) is created
 S:'$D(ARAY) ARAY="" Q:'$D(FIELD)  Q:'$D(CTR)
 N IFN,X
 S X=$S($O(ARAY(0)):$O(ARAY(9999),-1),1:ARAY)
 S:$L(FIELD)>244 FIELD=$E(FIELD,1,244)
 I $L(FIELD)+$L(X)>244 S CTR=CTR+1,ARAY(CTR)=""
 S:CTR=0 ARAY=ARAY_FIELD
 S:CTR ARAY(CTR)=ARAY(CTR)_FIELD
 Q
