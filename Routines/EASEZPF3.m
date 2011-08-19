EASEZPF3 ; ALB/SCK - Print 1010EZ Enrollment Form Cont. ; 10/25/2000
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
EN(EALNE,EAINFO) ;
 N EASIGN
 ;
 I $$GET1^DIQ(712,EAINFO("EASAPP")_",",4)]"" D
 . S EASIGN=$$GET1^DIQ(712,EAINFO("EASAPP")_",",4.1)
 S EASIGN=$G(EASIGN)
 ;
 D HDR^EASEZPF(.EALNE,.EAINFO)
 D REL
 D CON
 D FT^EASEZPF(.EALNE,.EAINFO)
 ;
 Q
 ;
REL ;
 W !?55,"SECTION III",!,EALNE("DD")
 W !,?50,"CONSENT TO RELEASE INFORMATION"
 W !!,"I hereby authorize the Department of Veterans Affairs to disclose any such history, diagnostic and treatment information from"
 W !,"my medical records (including information relating to the diagnosis, treatment of other therapy for the conditions of"
 W !,"substance abuse, alcoholism or alcohol abuse, sickle cell anemia, or testing for or infection with the human immunodeficiency"
 W !,"virus) to the contractor of any health plan contract under which I am apparently eligible for medical care or payment of the"
 W !,"expense of care or to any other party against whom liability is asserted. I understand that I may revoke this authorization"
 W !,"at any time, except to the extent that action has already been taken in reliance on it. Without my express revocation, this"
 W !,"consent will automatically expire when all action arising from VA's claim for reimbursement for my medical care has been"
 W !,"completed.  I authorize payment of medical benefits to VA for any services for which payment is accepted."
 ;
 W !,EALNE("D")
 W !,"SOCIAL SECURITY NUMBER  ",EAINFO("SSN"),?80,"| DATE OF BIRTH  ",$G(^TMP("EASEZ",$J,1,7))
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 W !,"SIGNATURE OF PATIENT",?80,"| DATE (mm/dd/yyyy)",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 W !!,EALNE("D"),!?50,"III - CONSENT AND SIGNATURE"
 W !?30,"ALL APPLICANTS MUST SIGN AND DATE THE APPLICATION FOR HEALTH BENEFITS"
 W !,EALNE("D")
 W !,"The Paperwork Reduction Act of 1995 requires us to notify you that this information collection is in accordance with the"
 W !,"clearance requirements of section 3507 of the Paperwork Reduction Act of 1995. We may not conduct or sponsor, and you are"
 W !,"not required to respond to, a collection of information unless it displays a valid OMB number.  We anticipate that the"
 W !,"time expended by all individuals who must complete this form will average 20 minutes. This includes the time it will take"
 W !,"to read instructions, gather the necessary facts and fill out the form."
 W !!,"Privacy Act Information: The VA is asking you to provide the information on this form under Title 38, United States Code, "
 W !,"sections 1710, 1712, and 1722 in order for VA to determine your eligibility for medical benefits. The information you supply"
 W !,"may be verified through a computer-matching program. VA may disclose the information that you put on the form as permitted by"
 W !,"law. VA may make a ""routine use"" disclosure for: civil or criminal law enforcement, congressional communications, "
 W !,"epidemiological or research studies, the collection of money owed to the United States, litigation in which the United States"
 W !,"is a party or has interest, the administration of VA programs and delivery of VA benefits, verification of identity and status,"
 W !,"and personnel administration. You do not have to provide the information to VA, but if you don't, we will be unable to "
 W !,"process your request and serve your medical needs. Failure to furnish the information will not have any affect on any other "
 W !,"benefits to which you may be entitled. If you give VA your Social Security Number, VA will use it to administer your VA "
 W !,"benefits, to identify veterans and persons claiming or receiving VA benefits and their records, and for other purposes "
 W !,"authorized or required by law."
 Q
 ;
CON ;
 W !!,"CO-PAYMENT NOTICE: If you are a 0% service-connected noncompensable or a nonservice-connected veteran (and are not an"
 W !,"Ex-POW, WWI veteran or VA pensioner) AND your household income (or combined income and net worth) exceeds the established"
 W !,"threshold, you may be eligible for enrollment only if you agree to pay VA co-payments for treatment of your NSC conditions."
 W !,"By signing this application you are agreeing to pay the applicable VA co-payment if required by law.",!
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 W !,?5,"I CERTIFY THE FOREGOING STATEMENT(S) ARE TRUE AND CORRECT TO THE BEST OF MY KNOWLEDGE AND ABILITY.",?110,"|Date (mm/dd/yyyy)"
 W !?110,"|",!,"SIGN HERE   "
 I $G(EASIGN)]"" W "SIGNATURE OF APPLICANT OR APPLICANT'S REPRESENTATIVE HAS BEEN VERIFIED",?110,"| ",EASIGN
 W ?131,$C(13) W:EALNE("ULC")="-" ! W EALNE("UL")
 ;
 W !,EALNE("DD"),!?24,"THE LAW PROVIDES SEVERE PENALTIES FOR WILLFUL SUBMISSION OF FALSE INFORMATION."
 Q
