DVBCAOC1 ;ALB ISC/THM-AGENT ORANGE/RESIDUALS OF DIOXIN, CONT. ; 5/21/91  10:05 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN W ?2,"b. Describe the following:",!!?6,"1.  General appearance and mental status -",!!!?6,"2.  Head and neck -",!!!?6,"3.  Eyes -",!!!?6,"4.  Ears -",!!!?6,"5.  Nose -",!!!?6,"6.  Mouth -",!!!?6,"7.  Throat -",!!!?6,"8.  Teeth -",!!!
 W ?6,"9.  Chest -",!!!?5,"10.  Lungs -",! D HD2^DVBCAOCK W ?5,"11.  Cardiovascular -",!!!?5,"12.  Abdomen -",!!!?5,"13.  Hernia -",!!!?5,"14.  Genitalia -",!!!?5,"15.  Rectum -",!!!?5,"16.  Prostate -",!!!?5,"17.  Back -",!!!
 W ?5,"18.  Extremeties -",!!!?5,"19.  Neurological -",!!!?5,"20.  Skin -",!!!?5,"21.  Lymphatics -",!!!!,"H.  Indicate whether or not there is evidence of neoplasia in",!?4,"the veteran:",!!!
 W "I.  Indicate whether or not there is evidence of neoplasia in",!?4,"the veteran's family and specify the family member and type",!?4,"of neoplasia, if known:",! D HD2^DVBCAOCK
 W "J.  Indicate if there is evidence of infertility, spontaneous",!?4,"abortions or teratogenesis in the veteran or the veteran's spouse",!?4,"or immediate family (and describe, if present):",!!!!!
 W "K.  Indicate if the veteran's spouse or children were in Vietnam",!?4,"(and if so, give details):",!!!!!,"L.  Diagnostic/clinical test results (indicate the results of",!?4,"the following, if performed):",!!
 W ?6,"a.  Complete blood count, including differential -",!!!?6,"b.  Chest X-Ray (if no chest X-Ray within six months) -",!!!?6,"c.  Liver function profile -",!!!?6,"d.  Renal function profile -",!!!?6,"e.  Sperm count -",!!!
 W ?6,"f.  Referral to a dermatologist -",! D HD2^DVBCAOCK W "M.  Diagnosis:",!!!!!!!!!!,"N.  The veteran has been informed of the results of this examination,",!?4,"including X-Ray, blood chemistry, urinalysis, and CBC tests and the",!
 W ?4,"following abnormalities were discussed (if none, write",!?4,"'NONE'):",!! S $P(XLN,"_",75)="_" W XLN,!!,XLN,!!,"Signature of veteran: ",$E(XLN,1,35)," Date: ",$E(XLN,1,11),!
 W !,"Examiner's signature: ",$E(XLN,1,35)," Date: ",$E(XLN,1,11),!!!
 W ?9,"Reviewed by: ",$E(XLN,1,35)," Date: ",$E(XLN,1,11),!?9,"Environmental Health Physician",! K XLN,LN,LN1,LN2,LNS
 Q
