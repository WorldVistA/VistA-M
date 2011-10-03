MCARAM3 ;WASH ISC/JKL-MUSE TRANSFER LAB DATA TO LOCAL ;5/2/96  12:49
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Modules to return lab data in a local array
 ; USAGE: S X=$$L#^MCARAM3(.A,B) , where # = integer from 7 to 12
 ; WHERE: .A=local array into which data is placed
 ;         B=1 line of lab data
 ;  if unsuccessful, returns an error message
 ;  if successful, returns a function value of 0 and a value array:
 ;  MCA(field #) = value of field
 ;  MCA("CONT") = diagnosis line # in alphabetic form
 ;  MCA("DX,#") = line of diagnosis data
 ;  MCA("DT") = date/time in FM format
 ;
L12(MCA,MCD) ;Returns Field 8 = P Axis, 9 = R Axis, 10 = T Axis, 
 ;        12 = Interpreted By, Pointer to File 200
 N MCERR
 S MCERR=$$AR^MCARAM4(.MCA,8,MCD,11,15,3)
 I +MCERR=2 K MCA(8) S MCERR=$$LOG^MCARAM7("2-P Axis is a null data field")
 I +MCERR=1 K MCA(8) S MCERR=$$LOG^MCARAM7("1-P Axis not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,9,MCD,16,19,3)
 I +MCERR=2 K MCA(9) S MCERR=$$LOG^MCARAM7("2-R Axis is a null data field")
 I +MCERR=1 K MCA(9) S MCERR=$$LOG^MCARAM7("1-R Axis not numeric")
 I +MCERR>50 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,10,MCD,20,31,3)
 I +MCERR=2 K MCA(10) S MCERR=$$LOG^MCARAM7("2-T Axis is a null data field")
 I +MCERR=1 K MCA(10) S MCERR=$$LOG^MCARAM7("1-T Axis not numeric")
 I +MCERR>50 Q MCERR
 I $$GRERR^MCARAM7(.MCA)=1 Q MCERR
 S MCERR=$$AR^MCARAM4(.MCA,12,MCD,67,134) I +MCERR=2 K MCA(12) S MCERR=$$PROEFF^MCARAM3(MCA("DT"),MCERR) Q $$LOG^MCARAM7(MCERR)
 I +MCERR>50 Q MCERR
 S MCA(12)=$P(MCA(12),": ",2) I MCA(12)="" K MCA(12) S MCERR=$$PROEFF^MCARAM3(MCA("DT"),MCERR) Q $$LOG^MCARAM7(MCERR)
 N MCPH S MCPH=MCA(12),MCERR=$$SLTS^MCARAM4(.MCPH),MCA(12)=MCPH K MCPH
 I +MCERR=2 K MCA(12) S MCERR=$$PROEFF^MCARAM3(MCA("DT"),MCERR) Q $$LOG^MCARAM7(MCERR)
 I MCA(12)["/",MCA(12)'[" " S MCA(12)=$P(MCA(12),"/")
 I MCA(12)["/" N MCA12 S MCA(12)=$P(MCA(12),"/") F MCA12=$L(MCA(12)):-1:1 I $E(MCA(12),MCA12)=" " S MCA(12)=$E(MCA(12),(MCA12+1),$L(MCA(12))) Q
 S:MCA(12)[" M.D.," MCA(12)=$P(MCA(12)," M.D.",1)_$P(MCA(12),"M.D.",2,99)
 S:MCA(12)[" M.D." MCA(12)=$P(MCA(12)," M.D.",1)_","_$P(MCA(12),"M.D. ",2,99)
 S:MCA(12)[" MD " MCA(12)=$P(MCA(12)," MD",1)_","_$P(MCA(12),"MD ",2,99)
 I $D(^VA(200,"B",MCA(12))) S MCA(12)=$O(^(MCA(12),0)) Q 0
 ;allow a match between DHCP provider name length and instrument name length
 N MCNAM,MCFNAM,MCLNAM,MC12NAM,MC12FNAM,MC12LNAM
 S MC12LNAM=$P(MCA(12),","),MC12FNAM=$P(MCA(12),",",2,99)
 I $E(MC12FNAM)=" " S MC12FNAM=$E(MC12FNAM,2,$L(MC12FNAM))
 S (MC12LNAM,MCLNAM)=$E(MC12LNAM,1,7),(MC12FNAM,MCFNAM)=$E(MC12FNAM,1,3)
 S (MC12NAM,MCNAM)=MC12LNAM_","_MC12FNAM
 I $D(^VA(200,"B",MCNAM)) S MCA(12)=$O(^(MCNAM,0)) D KNMK Q 0
 K MCA(12) F  S MCNAM=$O(^VA(200,"B",MCNAM)) Q:MCNAM=""  S MCLNAM=$P(MCNAM,","),MCFNAM=$P(MCNAM,",",2,99) Q:($E(MCLNAM,1,7)'=MC12LNAM)  I $E(MCLNAM,1,7)=MC12LNAM,$E(MCFNAM,1,3)=MC12FNAM S MCA(12)=$O(^(MCNAM,0)) Q
 D KNMK I $D(MCA(12)) Q 0
 I MCA("DT")>2950430 S MCERR="64-Interpreted By does not match name in New Person file" Q $$LOG^MCARAM7(MCERR)
 Q $$LOG^MCARAM7("13-Interpreted By does not match name in New Person file")
 ;
PROEFF(MCEDT,MCERR) ;Starting May 1, 1995, provider match is required to file record
 ; if provider does not match, returns fatal error message according
 ; to test date
 I MCEDT>2950430 S MCERR="63-Interpreted By is a null data field"
 K MCEDT Q MCERR
 ;
LDHCP(MCA,MCE)  ;load local array data into DHCP
 ; USAGE: S X=$$LDHCP^MCARAM3(.A,.B)
 ; WHERE: A=local array of data
 ;        B=DHCP data
 ; including MCE("EKG") =internal record number in EKG file
 ;transfer local array data into new EKG record in DHCP
 S MCERR=$$EKG^MCARAM5(.MCA,.MCE) I +MCERR>50 Q $$LOG^MCARAM7(MCERR)
 ;transfer local array diagnosis data into EKG record
 S MCERR=$$EKGDG^MCARAM5(.MCA,.MCE) I +MCERR>50 Q $$LOG^MCARAM7(MCERR)
 ;transfer local array medication data into EKG record
 S MCERR=$$EKGRX^MCARAM5(.MCA,.MCE) I +MCERR>50 Q $$LOG^MCARAM7(MCERR)
 ;transfer order and request/consultation data into EKG record
 S MCERR=$$EKGOR^MCARAM5(.MCA,.MCE) I +MCERR>50 Q $$LOG^MCARAM7(MCERR)
 Q 0
 ;
KNMK ; Kill name check variables
 K MCNAM,MCFNAM,MCLNAM,MC12NAM,MC12FNAM,MC12LNAM,MCA12 Q
 ;
ERR ;Error return
 Q MCERR
