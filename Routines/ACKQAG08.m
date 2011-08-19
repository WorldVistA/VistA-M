ACKQAG08 ;DDC/PJU;UPDATE AUDIOMETRIC EXAM FILE; [10/06/2005 ]
 ;;3.0;QUASAR AUDIOMETRIC MODULE;**12**;11/01/02;
 ;Loop through entries in 509850.9 and convert 'No Response' tags to
 ;'+' added to value in initial or final fields. Retest field
 ;was added with patch 12, so no tags that need conversion.
 N IEN,P,N,CTR S (CTR,IEN)=0 ;W !!,"START:",$$HTE^XLFDT($H)
L1 S IEN=$O(^ACK(509850.9,IEN)) G:'IEN PART2 ;S CTR=CTR+1
 I $D(^ACK(509850.9,IEN,11)) D  ;initial R air
 .F P=1:1:12 D
 ..S N=$P(^ACK(509850.9,IEN,11),U,P) Q:'N
 ..I (N=2)!(N=3) D  ;no response or masked no response
 ...I $P($G(^ACK(509850.9,IEN,10)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,11),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,10),U,P)=$P($G(^ACK(509850.9,IEN,10)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,11),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,21)) D
 .F P=1:1:12 D  ;final R air
 ..S N=$P(^ACK(509850.9,IEN,21),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,20)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,21),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,20),U,P)=$P($G(^ACK(509850.9,IEN,20)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,21),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,31)) D
 .F P=1:1:12 D  ;Initial L air
 ..S N=$P(^ACK(509850.9,IEN,31),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,30)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,31),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,30),U,P)=$P($G(^ACK(509850.9,IEN,30)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,31),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,41)) D
 .F P=1:1:12 D  ;final L air
 ..S N=$P($G(^ACK(509850.9,IEN,41)),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,40)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,41),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,40),U,P)=$P($G(^ACK(509850.9,IEN,40)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,41),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,71)) D
 .F P=1:1:9 D  ;Initial R bone
 ..S N=$P(^ACK(509850.9,IEN,71),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,70)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,71),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,70),U,P)=$P($G(^ACK(509850.9,IEN,70)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,71),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,76)) D
 .F P=1:1:9 D  ;Final R bone
 ..S N=$P(^ACK(509850.9,IEN,76),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,75)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,76),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,75),U,P)=$P($G(^ACK(509850.9,IEN,75)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,76),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,81)) D
 .F P=1:1:9 D  ;Initial L bone
 ..S N=$P(^ACK(509850.9,IEN,81),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,80)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,81),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,80),U,P)=$P($G(^ACK(509850.9,IEN,80)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,81),U,P)=$S(N=2:"",N=3:1)
 I $D(^ACK(509850.9,IEN,86)) D
 .F P=1:1:9 D  ;Final l bone
 ..S N=$P(^ACK(509850.9,IEN,86),U,P) Q:'N
 ..I (N=2)!(N=3) D
 ...I $P($G(^ACK(509850.9,IEN,85)),U,P)["+" D  Q
 ....S $P(^ACK(509850.9,IEN,86),U,P)=$S(N=2:"",N=3:1)
 ...S $P(^ACK(509850.9,IEN,85),U,P)=$P($G(^ACK(509850.9,IEN,85)),U,P)_"+"
 ...S $P(^ACK(509850.9,IEN,86),U,P)=$S(N=2:"",N=3:1)
 G L1
PART2 ;evaluate and move initial readings(masked) to final when needed
 ;W !!,"START PART2 :",$$HTE^XLFDT($H)
 N V1,T1,L1,V2,T2,L2 ;initial and final value, tag & mask level nodes
 N NV1,NL1,NT1,NV2,NL2,NT2 ;NODES FOR CHANGES IF NEEDED
 S IEN=0
L2 S IEN=$O(^ACK(509850.9,IEN)) G:'IEN END
 G:'$D(^ACK(509850.9,IEN,0)) L2 ;INVALID ENTRY
AIRR ;Right Air
 S NV1="^ACK(509850.9,"_IEN_",10)"
 S NT1="^ACK(509850.9,"_IEN_",11)"
 S NL1="^ACK(509850.9,"_IEN_",50)"
 S NV2="^ACK(509850.9,"_IEN_",20)"
 S NT2="^ACK(509850.9,"_IEN_",21)"
 S NL2="^ACK(509850.9,"_IEN_",51)"
 F P=1:1:12 D  ;
 .S V1=$P($G(^ACK(509850.9,IEN,10)),U,P)
 .S T1=$P($G(^ACK(509850.9,IEN,11)),U,P)
 .S L1=$P($G(^ACK(509850.9,IEN,50)),U,P)
 .S V2=$P($G(^ACK(509850.9,IEN,20)),U,P)
 .S T2=$P($G(^ACK(509850.9,IEN,21)),U,P)
 .S L2=$P($G(^ACK(509850.9,IEN,51)),U,P)
 .I (T1'="")!(T2'="")!(L1'="") D RULES()
AIRL ;Left Air
 S NV1="^ACK(509850.9,"_IEN_",30)"
 S NT1="^ACK(509850.9,"_IEN_",31)"
 S NL1="^ACK(509850.9,"_IEN_",60)"
 S NV2="^ACK(509850.9,"_IEN_",40)"
 S NT2="^ACK(509850.9,"_IEN_",41)"
 S NL2="^ACK(509850.9,"_IEN_",61)"
 F P=1:1:12 D  ;
 .S V1=$P($G(^ACK(509850.9,IEN,30)),U,P)
 .S T1=$P($G(^ACK(509850.9,IEN,31)),U,P)
 .S L1=$P($G(^ACK(509850.9,IEN,60)),U,P)
 .S V2=$P($G(^ACK(509850.9,IEN,40)),U,P)
 .S T2=$P($G(^ACK(509850.9,IEN,41)),U,P)
 .S L2=$P($G(^ACK(509850.9,IEN,61)),U,P)
 .I (T1'="")!(T2'="")!(L1'="") D RULES() ;apply rules
RBONE ;Right Bone
 S NV1="^ACK(509850.9,"_IEN_",70)"
 S NT1="^ACK(509850.9,"_IEN_",71)"
 S NL1="^ACK(509850.9,"_IEN_",90)"
 S NV2="^ACK(509850.9,"_IEN_",75)"
 S NT2="^ACK(509850.9,"_IEN_",76)"
 S NL2="^ACK(509850.9,"_IEN_",91)"
 F P=1:1:9 D
 .S V1=$P($G(^ACK(509850.9,IEN,70)),U,P)
 .S T1=$P($G(^ACK(509850.9,IEN,71)),U,P)
 .S L1=$P($G(^ACK(509850.9,IEN,90)),U,P)
 .S V2=$P($G(^ACK(509850.9,IEN,75)),U,P)
 .S T2=$P($G(^ACK(509850.9,IEN,76)),U,P)
 .S L2=$P($G(^ACK(509850.9,IEN,91)),U,P)
 .I (T1'="")!(T2'="")!(L1'="") D RULES() ;apply rules
LBONE ;Left Bone
 S NV1="^ACK(509850.9,"_IEN_",80)"
 S NT1="^ACK(509850.9,"_IEN_",81)"
 S NL1="^ACK(509850.9,"_IEN_",100)"
 S NV2="^ACK(509850.9,"_IEN_",85)"
 S NT2="^ACK(509850.9,"_IEN_",86)"
 S NL2="^ACK(509850.9,"_IEN_",101)"
 F P=1:1:9 D
 .S V1=$P($G(^ACK(509850.9,IEN,80)),U,P)
 .S T1=$P($G(^ACK(509850.9,IEN,81)),U,P)
 .S L1=$P($G(^ACK(509850.9,IEN,100)),U,P)
 .S V2=$P($G(^ACK(509850.9,IEN,85)),U,P)
 .S T2=$P($G(^ACK(509850.9,IEN,86)),U,P)
 .S L2=$P($G(^ACK(509850.9,IEN,101)),U,P)
 .I (T1'="")!(T2'="")!(L1'="") D RULES() ;apply rules
 G L2
END ;W !!,"STOP:",$$HTE^XLFDT($H),?60,"RECORDS:",CTR 
 S DIK="^ACK(509850.9,",DIK(1)=".02^DFN2" D ENALL^DIK K DIK
 Q
 ;
RULES() ;Adjust Masking level, tag and value for *3*12 if needed
 ;no CNT,DNT,CNM etc in 3*3 records but may have "+" from part1
 ;L2 could be CNM if a re-run,V1 could be CNT or DNT if a re-run
 ;1.final has val and (ML or mask tag) then will only use final on graph and just val for init
 N MS1,MS2 S (MS1,MS2)=""
 I L2!T2 S MS2=1 ;final masked 
 I L1'=""!T1 S MS1=1 ;initial masked
 I V2'="",MS2 D  Q  ;has final masked value
 .S $P(@(NT1),U,P)="" ;elim init tag
 .S $P(@(NT2),U,P)="" ;elim final tag
 .S $P(@(NL1),U,P)="" ;elim init ML
 .I T2,L2="",V2'["*" S $P(@(NV2),U,P)=V2_"*" ;adjust if just had tag
 ;2.fin missing Val or just + or ML and init has both then replace fin
 I (('MS2)!("+"[V2)),("+"'[V1),MS1 D  Q
 .I T1,L1="",V1'["*" S V1=V1_"*" ;adjust if just had tag
 .S $P(@(NV2),U,P)=V1 ;replace final val with initial val
 .S $P(@(NL2),U,P)=L1 ;replace final ML with initial ML
 .S $P(@(NT2),U,P)="" ;elim final tag
 .S $P(@(NV1),U,P)="" ;elim init val
 .S $P(@(NL1),U,P)="" ;elim init ML
 .S $P(@(NT1),U,P)="" ;elim init tag
 E  I (T1'="")!(T2'="")!(L1'="") D  ;eliminate 0's & invalid field values 
 .S $P(@(NT1),U,P)="" ;elim init tag
 .S $P(@(NT2),U,P)="" ;elim final tag
 .S $P(@(NL1),U,P)="" ;elim init ML
 Q
