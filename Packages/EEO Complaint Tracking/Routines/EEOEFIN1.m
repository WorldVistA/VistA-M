EEOEFIN1 ;HISC/JWR - TEXT FOR DATE NOTICE OF FINAL INTERVIEW LETTER ;APR 20, 1995
 ;;2.0;EEO Complaint Tracking;**1**;Apr 27, 1995
 ;ROUTINE HOLDING TEXT FOR REPORT OF FINAL INTERVIEW
START ;Starts the print
 U IO W:EEOII=IOS @IOF
 S Y=DT D DD^%DT
 F CON=1:1 K EEOI1 Q:CON>EEOCOP  W:CON>1 @IOF S EEOTX="" F CT=1:1 Q:EEOTX="***"  S EEOTX=$E($T(TEXT+CT),4,255) Q:EEOTX="***"  D
 .I EEOTX="****",$Y>IOSL-12,IOSL>40 W @IOF
 .D TXT^EEOERCR
 D IOF,EXIT Q
TEXT ;Text for the letter
 ;;;;0^80
 ;;     DEPARTMENT OF                                               MEMORANDUM
 ;;     VETERAN AFFAIRS
 ;; 
 ;; 
 ;;Date:  ^^EEODT^^
 ;; 
 ;;From:  ^^EEOCNAME^^
 ;; 
 ;;Subj:  Notice of Final Interview With EEO Counselor
 ;; 
 ;;  To:  ^^EEONAME^^
 ;;;;8^72
 ;; 
 ;; 
 ;;1. This is notice that I have completed my EEO counseling activities in connection with the matter which you presented to me.  If you are not satisfied with the results of EEO counseling, you now have the right
 ;;*to file a formal complaint of discrimination.  If you decide to file a formal complaint, you must do so within 15-calendar days of your receipt of this notice.
 ;; 
 ;;2. Attached is VA Form 4939, Complaint of Employment Discrimination.  Please use this form and read the instructions on the reverse side before completing it.  I am available to assist you in filling out this form. 
 ;;*If you desire my assistance, please contact me immediately.  The time limit for filing a formal complaint will not be extended due to your desire to seek my assistance. 
 ;; 
 ;;3. You may file a formal complaint in person or by mail with the EEO Officer at this facility, (^^EEOOFF^^) or with the Federal Woman's Program Manager (FWPM) or with the Secretary of Veterans Affairs or with the Deputy Assistant Secretary
 ;;*for Equal Opportunity (DAS/EO).  The address of the Secretary, FWPM, EEO Officer and of the DAS/EO are:
 ;; 
 ;; 
 ;;Deputy Assistant Secretary for       ^^EEOOFF^^
 ;;  Equal Employment Opportunity       ^^EEOTITL^^
 ;;Office of Equal Opportunity (06A)    ^^EEOLIN(1)^^
 ;;Department of Veterans Affairs       ^^EEOLIN(2)^^
 ;;810 Vermont Avenue, NW               ^^EEOLIN(3)^^
 ;;Washington, D.C. 20420      
 ;; 
 ;;Secretary                            Federal Woman's Program Manager
 ;;Department of Veterans Affairs       Office of Equal Opportunity (06)
 ;;810 Vermont Avenue, NW               Department of Veterans Affairs
 ;;Washington, D.C. 20420               810 Vermont Avenue, NW
 ;;                                     Washington, D.C. 20420
 ;; 
 ;;Present regulations require the EEO Officer at this facility to assemble and review your complaint file, to determine whether your complaint meets all requirements for investigation.
 ;;*Therefore, if you file your complaint with the Secretary or with the FWPM or with the DAS/EO, you should send a copy to the EEO Officer at this facility.  Failure to do so will delay the processing of your complaint.
 ;; 
 ;;4. Your formal complaint must identify each event you are protesting and provide the date on which each event occurred.  Your complaint must be specific and limited to the events you discussed with me.  Regulations provide
 ;;*for dismissal of any events not discussed with an EEO Counselor.  Therefore, if there are any events which you have not discussed with me, but wish to include in your formal complaint, you should discuss them with me immediately.
 ;; 
 ;;5. You are entitled to be represented at every stage of the complaint process.  If you retain a representative, you must inform the EEO Officer of his or her name, address, and telephone number.
 ;; 
 ;;6. If you are a member of the bargaining unit, you may have the right to dispute the events you discussed with me through the union grievance procedure.  Regulations provide that you may file a grievance or an EEO complaint 
 ;;*about the events in dispute, but not both.  Whichever you file first will be processed.  The other will be dismissed.
 ;; 
 ;;7. If I can be of further assistance to you, please advise.
 ;;
 ;; 
 ;; 
 ;; 
 ;;                           _____________________________________
 ;;                           Signature of Aggrieved           Date
 ;; 
 ;; 
 ;;                           _____________________________________
 ;;                           Signature of EEO Counselor       Date
 ;; 
 ;;***
 ;; 
EXIT D ^%ZISC D KILL^EEOEOSE K EEOOFF,EEOCNAME,EEOCOP,EEOFLNAM,EEOFORM,EEOLTH,EEOTX,EEOTX1,EEOLIN,EEOSEL Q
IOF W:IO(0)'=IO @IOF Q
