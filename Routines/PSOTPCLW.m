PSOTPCLW ;BIRM/PDW-ROUTINE FOR STORE & PRINT LETTERS
 ;;7.0;OUTPATIENT PHARMACY;**145**;DEC 1997
 Q
LOADTMP ;Load letter text into ^TMP($J,"TPCLW","Px")
 ;This builds the patient letter for TIME NEW ROMAN 12 POINT (NOT 12 PITCH)
 K ^TMP($J,"TPCLW"),INDENT
 S $P(INDENT," ",5)=""
 F LN=1:1 S XX=$T(MMLETTER+LN) Q:XX["*****"  S XX=$P(XX,";;",2),^TMP($J,"TPCLW","P1",LN)=INDENT_XX
 S LN1=LN
 F LN=1:1 S YY=LN1+LN,XX=$T(MMLETTER+YY) Q:XX["*****"  S XX=$P(XX,";;",2),^TMP($J,"TPCLW","P2",LN)=INDENT_XX
 S LN1=LN+LN1
 F LN=1:1 S YY=LN1+LN,XX=$T(MMLETTER+YY) Q:XX["*****"  S XX=$P(XX,";;",2),^TMP($J,"TPCLW","P3",LN)=INDENT_XX
 S LN1=LN+LN1
 Q
TMP ; show TMP contents
 S X=132 X ^%ZOSF("RM")
 F XX="P1","P2","P3" W !!,XX,! S LN=0 F  S LN=$O(^TMP($J,"TPCLW",XX,LN)) Q:LN'>0  S X=^(LN) W !,X
 S X=80 X ^%ZOSF("RM")
 Q
SETUP ;pull text lines from mailman message and store into routine
SETUPB D SELBSK Q:Y'>0
 D SELMSG G:Y'>0 SETUPB
 D MMLOAD
 Q
SELBSK ;SELECT BASKET,DA
 K DIC,DA S BSKDA=0
 S DA(1)=DUZ,DIC="^XMB(3.7,DA(1),2,",DIC(0)="AEQM"
 D ^DIC
 S:+Y>0 BSKDA=+Y
 Q
SELMSG ;SELECT MESSAGE
 K DIC,DA S MSGDA=0,IENS=BSKDA_","_DUZ
 W !!,"Basket: ",$$GET1^DIQ(3.701,IENS,.01)
 S DA(2)=DUZ,DA(1)=BSKDA,DIC="^XMB(3.7,DUZ,2,BSKDA,1,",DIC(0)="AEQM"
 S DIC("W")="W $$GET1^DIQ(3.9,+Y,.01)"
 D ^DIC K DIC,DR,DA
 S:+Y>0 MSGDA=+Y
 Q
MMLOAD ; Load text into routine from a mail message.
 S MMDA=$G(MSGDA) Q:+MMDA'>0
 S X1="S XX=""MMLETTER ;;"" ZI XX"
 S X2="S LN=0 F  S LN=$O(^XMB(3.9,MMDA,2,LN)) Q:LN'>0  S XX="" ;;""_^XMB(3.9,MMDA,2,LN,0) ZI XX"
 X X1,X2,"ZS"
 Q
MMLETTER ;;
 ;;Dear Veteran:
 ;; 
 ;;I am pleased to tell you that you may be eligible for a new, temporary 
 ;;prescription benefit, called the VA Transitional Pharmacy Benefit.  The 
 ;;goal is to reduce the costs of your medication while you are waiting to 
 ;;see a VA primary care doctor.
 ;; 
 ;;1.  AM I ELIGIBLE FOR THIS NEW BENEFIT?
 ;; 
 ;;You are eligible for this benefit if you meet all of the following 
 ;;requirements.
 ;; 
 ;;        a.  You are enrolled in the VA health care system prior to July 
 ;;25, 2003; and
 ;;        b.  You have requested your first primary care appointment with 
 ;;VA prior to July 25, 2003; and
 ;;        c.  You have been waiting more than 30 days for the initial 
 ;;primary care appointment as of September 22, 2003.
 ;; 
 ;;2.  WHAT IS THE NEW BENEFIT?
 ;; 
 ;;        The new benefit allows VA to fill your prescriptions written by a 
 ;;non-VA doctor, until you have your first primary care appointment with 
 ;;VA.  VA will only provide your medications by mail.  VA may also bill 
 ;;your health insurance, and you may have to pay a co-payment based on your 
 ;;eligibility and financial status.
 ;; 
 ;;        The medications provided by this benefit include many of the drugs 
 ;;listed on the VA National Formulary List.  We have enclosed a shortened 
 ;;version of that list for your doctor's use.  Under this program, VA will 
 ;;not provide controlled substances (such as narcotics), intravenous
 ;;medications, over-the-counter medications (except insulin and 
 ;;syringes), medical supplies, and one-time medications for acute illnesses 
 ;;(such as antibiotics).  Additionally, VA will not provide medications 
 ;;required to be administered only by a medical professional.
 ;; 
 ;;3.  HOW DO I START?
 ;; 
 ;;        To obtain your medications, please do the following:
 ;; 
 ;;        a.  Fill out the top portion of the attached VA Form 10-0411, 
 ;;VA Transitional Pharmacy Benefit (the Patient Information part).
 ;;        b.  Take the attached letter ("Dear Doctor"), the enclosed 
 ;;Transitional Pharmacy Benefit Drug Formulary Summary brochure, and VA 
 ;;Form 10-0411, VA Transitional Pharmacy Benefit, to your private doctor. 
 ;;        c.  Ask your doctor to:
 ;; 
 ;;        (1)  Complete the Doctor Information section of VA Form 10-0411.
 ;;        (2)  Attach a prescription for each medication and include your 
 ;;name and social security number; and
 ;;        (3)  Mail these documents to the following address using the
 ;;enclosed envelope.
 ;; 
 ;;*****
 ;; 
 ;;4.  HOW WILL I GET MY MEDICATIONS?
 ;; 
 ;;        Prescriptions from your non-VA doctor must be mailed in the 
 ;;enclosed envelope to the address shown above.  Our goal is to mail your 
 ;;medications to you within 7 to 10 days after receiving your 
 ;;prescription.  If you have questions or concerns about your mailed 
 ;;medications, you may contact 
 ;;***** 
 ;;VA will provide sufficient medication to meet your needs until your first 
 ;;primary care appointment.  Please make sure your doctor mails the 
 ;;enclosed form and prescriptions.  VA is not able to process these 
 ;;prescriptions by fax, phone, or email.  If your doctor does not provide 
 ;;all the requested information, VA cannot send your medication.
 ;; 
 ;;5.  WHERE CAN I GET MORE INFORMATION?
 ;; 
 ;;        More information about this benefit can be found on the VA's 
 ;;Internet Web site, at http://www.va.gov/elig/tpb.htm.  If you still have
 ;;questions, please call 1-877-222-8387.
 ;; 
 ;;6.  PLEASE KEEP YOUR FIRST PRIMARY CARE APPOINTMENT!
 ;; 
 ;;        Once VA has scheduled your first primary care appointment, please 
 ;;remember that it is very important to keep that appointment.  If you must 
 ;;cancel your appointment, please advise the appointment clerk that you are 
 ;;a VA Transitional Pharmacy Benefits patient and explain why you are 
 ;;canceling.  VA understands that there are occasions when you must cancel 
 ;;your appointment.  However, if you cancel your appointment simply for 
 ;;your own convenience, or if you fail to show up for your scheduled 
 ;;appointment without an acceptable reason, you may no longer be eligible 
 ;;for this benefit.
 ;; 
 ;;        During your first primary care appointment, your VA doctor will 
 ;;review all treatments, including all your medications, and make changes 
 ;;as appropriate and give you refills.
 ;; 
 ;;        VA is committed to serving you by providing this benefit to 
 ;;reduce your medication costs while you wait for your first primary care 
 ;;appointment.  Thank you for your patience.  We hope to see you soon.
 ;;***** 
