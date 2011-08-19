VAFCPID2 ;ALB/MLI,PKE-Create generic PID segment ; 22 Jan 2002 10:30 AM
 ;;5.3;Registration;**149,240,312,428,494**;Aug 13, 1993
 ; aggressive name re-formatting
 ;
NAME(DFN,MPISTR,FLG) ;Being aggressive about where Suffix is placed, extra punctuation
 ;DFN - ien from Patient file  MPISTR - name as stored in Patient file
 ;FLG - Parameter no longer supported.  Originally denoted whether or
 ;      not to update the patient file.  Patient file will not be
 ;      updated anymore.
 I $E(MPISTR,1,14)="MERGING INTO `" S MPISTR=$P($P(MPISTR,"(",2),")") Q  ;**240
 S FLG=0
 N LAST,FIRST,MIDDLE,SUFFIX,POS,LAST12,LAST2,LAST3,REST,SUF,SEC,SEC12,SEC3,MID12,MID3,FIR12,FIR3,PL,MID3,TMPSTR,TFLG
 S TFLG="N"
 S TMPSTR=MPISTR
 I $E(MPISTR,($L(MPISTR)-4),$L(MPISTR))=" TEST" S MPISTR=$E(MPISTR,1,($L(MPISTR)-4)),TFLG="Y"
 I MPISTR["'" S MPISTR=$TR(MPISTR,"'","") ;Remove ' punctuation marks from the name
 S MPISTR=$TR(MPISTR,"."," ") I $E(MPISTR,$L(MPISTR))=" " S MPISTR=$E(MPISTR,1,$L(MPISTR)-1)
 ;check if 3rd instead of III
 I $F(MPISTR,"3RD")'=0 S MPISTR=$E(MPISTR,1,$F(MPISTR,"3RD")-4)_"III"_$E(MPISTR,$F(MPISTR,"3RD"),$L(MPISTR))
 ;check if 2nd instead of II
 I $F(MPISTR,"2ND")'=0 S MPISTR=$E(MPISTR,1,$F(MPISTR,"2ND")-4)_"II"_$E(MPISTR,$F(MPISTR,"2ND"),$L(MPISTR))
 I $P(MPISTR,",",3)'="" S PL=$F(MPISTR,","),FIRST=$E(MPISTR,PL,$L(MPISTR)),MPISTR=$P(MPISTR,",")_","_$TR(FIRST,","," ")
TR I $F(MPISTR,"  ") S PL=$F(MPISTR,"  "),MPISTR=$E(MPISTR,1,PL-2)_$E(MPISTR,PL,$L(MPISTR)) G TR
 ;check for more than three pieces after the comma - ex: last,j.r. first mi
 I $P(MPISTR,",",2)?.A1" ".A1" ".A1" ".A S REST=$P(MPISTR,",",2) I $E(REST,1,4)?1A1" "1A1" " S POS=$E(REST,1)_$E(REST,3) D
 .I POS="II"!(POS="IV")!(POS="VI")!(POS="JR")!(POS="SR")!(POS="DR") S SUF="Y" S MPISTR=$P(MPISTR,",")_","_$E(REST,5,$L(REST))_" "_POS,POS="Y"
 ;move the suffix from the left of the comma to the end of the name str
 S LAST=$P(MPISTR,","),REST=$P(MPISTR,",",2),POS="N",SUF="N"
 I LAST?.A1" ".E D
 .S LAST2=$P(LAST," ",2),LAST12=$E(LAST2,1,2),LAST3=$E(LAST2,3)
 .I LAST12="V"!(LAST12="V.")!(LAST12="I")!(LAST12="I.") S POS="Y",SUFFIX=LAST2
 .I LAST12="JR"!(LAST12="SR")!(LAST12="DR")!(LAST12="MD")!(LAST12="II")!(LAST12="IV")!(LAST12="VI") S POS="Y",SUFFIX=LAST2
 .I POS="Y",(LAST12="II") I LAST3'="",(LAST3'="."),(LAST3'="I") S POS="N",SUFFIX=""
 .I POS="Y",(LAST12="VI") I LAST3'="",(LAST3'="."),(LAST3'="I") S POS="N",SUFFIX=""
 .I POS="Y",LAST12'="II",LAST12'="VI" I LAST3'=""&(LAST3'=".") S POS="N"
 .I LAST12="ES"&(LAST3="Q") S POS="Y",SUFFIX=LAST2
 .I $D(SUFFIX) S SUFFIX=$TR(SUFFIX,".","")
 .I POS="Y" S MPISTR=$P(LAST," ")_","_REST_" "_SUFFIX,POS="N",SUF="Y"
 I POS="N",$P(MPISTR,",")[" " D
 .S LAST=$P(MPISTR,","),LAST2=$P(LAST," ",2) I $P(LAST," ",3)'="" S MPISTR=$P(LAST," ")_LAST2_" "_$P(LAST," ",3)_","_$P(MPISTR,",",2)
 ;
SP ;remove any extra spaces
 I $F(MPISTR,"  ") S PL=$F(MPISTR,"  "),MPISTR=$E(MPISTR,1,PL-2)_$E(MPISTR,PL,$L(MPISTR)) G SP
 ;Check for middle name existence with suffix to put a place holder of ""
 S SEC=$P(MPISTR,",",2),FIRST=$P(SEC," "),MIDDLE=$P(SEC," ",2),SUFFIX=$P(SEC," ",3)
 I SUFFIX="",SUF="Y" S SUFFIX=MIDDLE,MIDDLE="""""",MPISTR=$P(MPISTR,",")_","_FIRST_" "_MIDDLE_" "_SUFFIX
 ; ^ SUF="Y" means we moved it from left to right of comma
 I SUFFIX="",SUF="N" D
 .S MID12=$E(MIDDLE,1,2),MID3=$E(MIDDLE,3) ;Check if MIDDLE is a suffix
 .I MID12="ES"&(MID3="Q") S POS="Y"
 .I MID12="JR"!(MID12="SR")!(MID12="DR")!(MID12="MD")!(MID12="II")!(MID12="IV")!(MID12="VI") S POS="Y"
 .I POS="Y",(MID12="II") I MID3'="",(MID3'="."),(MID3'="I") S POS="N",SUFFIX=""
 .I POS="Y",(MID12="VI") I MID3'="",(MID3'="."),(MID3'="I") S POS="N",SUFFIX=""
 .I POS="Y",MID12'="II",MID12'="VI" I MID3'=""&(MID3'=".") S POS="N"
 .I POS="Y" S SUFFIX=MIDDLE,MIDDLE=""""""
 .S MPISTR=$P(MPISTR,",")_","_FIRST_" "_MIDDLE_" "_SUFFIX
 S POS="N"
 S FIR12=$E(FIRST,1,2),FIR3=$E(FIRST,3) ;check if FIRST is a suffix
 I FIR12="ES"&(FIR3="Q") S POS="Y"
 I FIR12="JR"!(FIR12="SR")!(FIR12="DR")!(FIR12="MD")!(FIR12="II")!(FIR12="IV")!(FIR12="VI") S POS="Y"
 I POS="Y",(FIR12="II") I FIR3'="",(FIR3'="."),(FIR3'="I") S POS="N",SUFFIX=""
 I POS="Y",(FIR12="VI") I FIR3'="",(FIR3'="."),(FIR3'="I") S POS="N",SUFFIX=""
 I POS="Y",FIR12'="II",FIR12'="VI" I FIR3'=""&(FIR3'=".") S POS="N"
 ; if no middle name can't be sure if initials or suffix so will leave as initials
 I POS="Y",MIDDLE="" S MPISTR=$P(MPISTR,",")_","_$E(FIR12,1)_" "_$E(FIR12,2) S POS="N"
 I TFLG="Y" S MPISTR=MPISTR_" TEST"
 I POS="Y" S MPISTR=$P(MPISTR,",")_","_MIDDLE_" "_$S(SUFFIX="":"""""",1:SUFFIX)_" "_FIRST
SP2 ;remove any extra spaces
 I $F(MPISTR,"  ") S PL=$F(MPISTR,"  "),MPISTR=$E(MPISTR,1,PL-2)_$E(MPISTR,PL,$L(MPISTR)) G SP2
 I $E(MPISTR,$L(MPISTR))=" " S MPISTR=$E(MPISTR,1,($L(MPISTR)-1))
 Q
