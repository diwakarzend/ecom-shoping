import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermConditionMobile extends StatefulWidget {
  const TermConditionMobile({super.key});

  @override
  State<TermConditionMobile> createState() => _TermConditionMobileState();
}

class _TermConditionMobileState extends State<TermConditionMobile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Define the text content as a constant or separate variable if needed
    final String policyText = 'Terms of Use\n\n'
        'Access to and use of agile and the products and service available through the website are subject to the following terms, conditions and notices (“Terms of Service”). By browsing through these Terms of Service and using the services provided by our website (www.agile.in), you agree to all Terms of Service along with the Privacy Policy on our website, which may be updated by us from time to time. Please check this page regularly to take notice of any changes we may have made to the Terms of Service. We reserve the right to review and withdraw or amend the services without notice. We will not be liable if for any reason this Website is unavailable at any time or for any period. From time to time, we may restrict access to some parts or this entire Website.\n\n'
        'Introduction\n\n'
        'The domain name www.agile.co.in, a company incorporated under laws of India with our registered office at:- 4th Floor, Office No.432, Geras Imperium Star, Tiswadi, Patto, Panaji, North Goa, Goa, 403001.\n\n'
        'meha digitek is an online retailer of apparel and lifestyle products offered at great values to the consumer. Membership allows customers to purchase a variety of products. Upon placing an order, agile.in shall ship the product to you and be entitled to its payment for the service. Additionally, we may provide you with information about other services, we consider similar to those that you are either already using, or have enquired about, or that may interest you or any combination thereof. Upon registering with us, we may contact you by electronic means (i.e. either e-mail or SMS or telephone or any combination thereof) to inform about these services.\n\n'
        'Third Party Websites and Content\n\n'
        'Our website provides links for sharing our content on facebook, twitter and other such third party website. These are only for sharing and/or listing purpose and we take no responsibility of the third party websites and/or their contents listed on our website www.agile.in and disclaim all our liabilities arising out of any or all third party websites.\n\n'
        'We disclaim all liabilities and take no responsibility for the content that may be posted on such third party websites by the users of such websites in their personal capacity on any of the above mentioned links for sharing and/or listing purposes as well as any content and/or comments that may be posted by such user in their personal capacity on any official webpage of agile on any social networking platform.\n\n'
        'Privacy\n\n'
        'Our Privacy Policy incorporated by reference in these Terms of Service, sets out how we will use personal information you provide to us. By using this Website, you agree to be bound by the Privacy Policy, and warrant that all data provided by you is accurate and up to date.\n\n'
        'Exactness of the Product\n\n'
        'The images of the items on the website are for illustrative purposes only. Although we have made every effort to display the colours accurately, we cannot guarantee that your computer’s display of the colours accurately reflect the colour of the items. Your items may vary slightly from those images. All sizes and measurements of items are approximate; however, we do make every effort to ensure they are accurate as possible. We take all reasonable care to ensure that all details, descriptions and prices of items are as accurate as possible.\n\n'
        'Pricing\n\n'
        'We ensure that all details of prices appearing on the website are accurate, however errors may occur. If we discover an error in the price of any goods which you have ordered, we will inform you of this as soon as possible. If we are unable to contact you, we will treat the order as cancelled. If you cancel and you have already paid for the goods, you will receive a full refund. The products available on the website are for retail sales, intended for end user consumption and are in no way available for resale. Additionally, prices for items may change from time to time without notice. However, these changes will not affect orders that have already been dispatched. The price of an item includes VAT, goods and service tax (or similar taxes) at the prevailing rate for which we are responsible as a seller. Please note that the prices listed on the website are only applicable for items purchased on the website and not through any other source.\n\n'
        'Payment\n\n'
        'Upon receiving your order we carry out a standard pre-authorization check on your payment card to ensure there are sufficient funds to fulfil the transaction. Goods will not be dispatched until this pre-authorization check has been completed. Your card will be debited once the order has been accepted. For any further payment related queries, please check our FAQs on Payment Mode.\n\n'
        'Delivery\n\n'
        'You will be given various options for delivery of items during the order process. The options available to you will vary depending on where you are ordering from. An estimated delivery time is displayed on the order summary page. On placing your order, you will receive an email containing a summary of the order and also the estimated delivery time to your location. Sometimes, delivery may take longer due to unforeseen circumstances. In such cases, we will proactively reach out to you by e-mail and SMS. However, we will not be able to compensate for any mental agony caused due to delay in delivery.\n\n'
        'Returns & Refund\n\n'
        'If you change your mind about any items purchased, you can return them to us. For more information on Returns and Refund, please refer to our Return Policy.\n\n'
        'Intellectual Property Rights\n\n'
        'All and any intellectual property rights in connection with the products shall be owned absolutely by the Company.\n\n'
        'Law and Jurisdiction\n\n'
        'These terms shall be governed by and construed in accordance with the laws of India without reference to conflict of laws principles and disputes arising in relation hereto shall be subject to the exclusive jurisdiction of the courts at Mumbai.\n\n'
        'Indemnification\n\n'
        'You agree to indemnify, defend and hold harmless the Company, its directors, officers, employees, consultants, agents, and affiliates, from any and all third party claims, liability, damages or costs arising from your use of this website, your breach of these Terms of Service, or infringement of any intellectual property right.\n\n'
        'Violation & Termination\n\n'
        'You agree that the Company may, in its sole discretion and without prior notice, terminate your access to the website and block your future access if we determine that you have violated these Terms of Service or any other policies. If you or the Company terminates your use of any service, you shall still be liable to pay for any service that you have already ordered till the time of such termination.\n\n'
        'Disclaimer\n\n'
        'IN NO EVENT WILL THE COMPANY OR ITS REPRESENTATIVES BE LIABLE FOR ANY DAMAGES, ARISING OUT OF OR RELATED TO MISUSE OF PERSONAL INFORMATION OF THE CUSTOMER AND THE CUSTOMER IS SOLELY LIABLE FOR SUCH ACTS AND THEY ARE ADVISED NOT TO SHARE THEIR CONFIDENTIAL INFORMATION LIKE OTP, CREDIT/DEBIT CARD EXPIRY AND CVV WITH ANYONE EVEN THOUGH THEY CLAIM TO BE A MEHYA DIGITECH PRIVATE LIMITED EMPLOYEE. NONE OF OUR EMPLOYEES WILL ASK FOR SUCH TYPE OF QUESTIONS.';

    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Term & Condition'),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              policyText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        );
      },
    );
  }
}