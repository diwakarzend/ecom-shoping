import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermConditionDesktop extends StatefulWidget {
  const TermConditionDesktop({super.key});

  @override
  State<TermConditionDesktop> createState() => _TermConditionDesktopState();
}

class _TermConditionDesktopState extends State<TermConditionDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final String shippingPolicyText = """
Terms of Use

Access to and use of Omegaasa and the products and service available through the website are subject to the following terms, conditions, and notices (“Terms of Service”). By browsing through these Terms of Service and using the services provided by our website (shop.Omegaasacloth.com), you agree to all Terms of Service along with the Privacy Policy on our website, which may be updated by us from time to time. Please check this page regularly to take notice of any changes we may have made to the Terms of Service. We reserve the right to review and withdraw or amend the services without notice. We will not be liable if for any reason this Website is unavailable at any time or for any period. From time to time, we may restrict access to some parts or this entire Website.

Introduction

The domain name shop.Omegaasacloth.com, a company incorporated under the laws of India with our registered office at:- 355, PLOT NO 4, 3RD FLOOR, COMMUNITY CENTER, SEC-14, Rithala, North West Delhi, Delhi- 110085.

Omegaasa is an online retailer of apparel and lifestyle products offered at great values to the consumer. Membership allows customers to purchase a variety of products. Upon placing an order, Omegaasa.in shall ship the product to you and be entitled to its payment for the service. Additionally, we may provide you with information about other services, we consider similar to those that you are either already using, or have enquired about, or that may interest you or any combination thereof. Upon registering with us, we may contact you by electronic means (i.e. either e-mail or SMS or telephone or any combination thereof) to inform you about these services.

Third Party Websites and Content

Our website provides links for sharing our content on Facebook, Twitter, and other such third-party websites. These are only for sharing and/or listing purposes, and we take no responsibility for the third-party websites and/or their contents listed on our website shop.Omegaasacloth.com and disclaim all our liabilities arising out of any or all third-party websites.

We disclaim all liabilities and take no responsibility for the content that may be posted on such third-party websites by the users of such websites in their personal capacity on any of the above-mentioned links for sharing and/or listing purposes as well as any content and/or comments that may be posted by such users in their personal capacity on any official webpage of Omegaasa on any social networking platform.

Privacy

Our Privacy Policy, incorporated by reference in these Terms of Service, sets out how we will use personal information you provide to us. By using this Website, you agree to be bound by the Privacy Policy and warrant that all data provided by you is accurate and up to date.

Exactness of the Product

The images of the items on the website are for illustrative purposes only. Although we have made every effort to display the colors accurately, we cannot guarantee that your computer’s display of the colors accurately reflects the color of the items. Your items may vary slightly from those images. All sizes and measurements of items are approximate; however, we do make every effort to ensure they are as accurate as possible. We take all reasonable care to ensure that all details, descriptions, and prices of items are as accurate as possible.

Pricing

We ensure that all details of prices appearing on the website are accurate; however, errors may occur. If we discover an error in the price of any goods which you have ordered, we will inform you of this as soon as possible. If we are unable to contact you, we will treat the order as canceled. If you cancel and you have already paid for the goods, you will receive a full refund. The products available on the website are for retail sales, intended for end-user consumption, and are in no way available for resale. Additionally, prices for items may change from time to time without notice. However, these changes will not affect orders that have already been dispatched. The price of an item includes VAT, goods, and service tax (or similar taxes) at the prevailing rate for which we are responsible as a seller. Please note that the prices listed on the website are only applicable for items purchased on the website and not through any other source.

Payment

Upon receiving your order, we carry out a standard pre-authorization check on your payment card to ensure there are sufficient funds to fulfill the transaction. Goods will not be dispatched until this pre-authorization check has been completed. Your card will be debited once the order has been accepted. For any further payment-related queries, please check our FAQs on Payment Mode.

Delivery

You will be given various options for delivery of items during the order process. The options available to you will vary depending on where you are ordering from. An estimated delivery time is displayed on the order summary page. On placing your order, you will receive an email containing a summary of the order and also the estimated delivery time to your location. Sometimes, delivery may take longer due to unforeseen circumstances. In such cases, we will proactively reach out to you by e-mail and SMS. However, we will not be able to compensate for any mental agony caused due to the delay in delivery.

Returns & Refund

If you change your mind about any items purchased, you can return them to us. For more information on Returns and Refund, please refer to our Return Policy.

Intellectual Property Rights

All and any intellectual property rights in connection with the products shall be owned absolutely by the Company.

Law and Jurisdiction

These terms shall be governed by and construed in accordance with the laws of India without reference to conflict of laws principles and disputes arising in relation hereto shall be subject to the exclusive jurisdiction of the courts at Mumbai.

Indemnification

You agree to indemnify, defend, and hold harmless the Company, its directors, officers, employees, consultants, agents, and affiliates, from any and all third-party claims, liability, damages, or costs arising from your use of this website, your breach of these Terms of Service, or infringement of any intellectual property right.

Violation & Termination

You agree that the Company may, in its sole discretion and without prior notice, terminate your access to the website and block your future access if we determine that you have violated these Terms of Service or any other policies. If you or the Company terminates your use of any service, you shall still be liable to pay for any service that you have already ordered till the time of such termination.

Disclaimer
 IN NO EVENT WILL THE COMPANY OR ITS REPRESENTATIVES BE LIABLE FOR ANY DAMAGES, ARISING OUT OF OR RELATED TO MISUSE OF PERSONAL INFORMATION OF THE CUSTOMER AND THE CUSTOMER IS SOLELY LIABLE FOR SUCH ACTS AND THEY ARE ADVISED NOT TO SHARE THEIR CONFIDENTIAL INFORMATION LIKE OTP, CREDIT/DEBIT CARD EXPIRY AND CVV WITH ANYONE EVEN THOUGH THEY CLAIM TO BE A OMEGAASA PERFECT MARKETING PRIVATE LIMITED EMPLOYEE. NONE OF OUR EMPLOYEES WILL ASK FOR SUCH TYPE OF QUESTIONS.
""";

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const TopAppBar(),
            Container(
              padding: EdgeInsets.only(top: height * .10, left: width * .12, right: width * .12),
              width: width,
              height: height * .20,
              color: const Color(0xff030d4e),
              child: const Text(
                'Term & Condition',
                style: TextStyle(
                    fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * .12, vertical: height * .08),
              child: Text(
                shippingPolicyText,
                maxLines: 100000000000000000,
                style: TextHelper.smallTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}