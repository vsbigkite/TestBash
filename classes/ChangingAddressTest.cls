/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ChangingAddressTest {
    static testMethod void InsertingANewContactTest() {
    	
    	Account a = new Account(Name ='TestAccount1', BillingPostalCode = '123456');
    	Insert a;
	    Contact c = new Contact(FirstName = 'A', LastName = 'M', AccountId = a.Id);
   		
       	test.startTest();
       	
       	Insert c;
            	
    	test.stopTest();
    	}
    	
    	static testMethod void UpdateingContactTest(){
	       	Account a = new Account(Name ='TestAccount1', BillingPostalCode = '123456');
	       	insert a;
	       	//test.startTest();
	       	
		   	Contact c = new Contact(FirstName = 'A', LastName = 'M', AccountId = a.Id);
		   	insert c;
		   	
	       	c.MailingPostalCode = 'aaaaaaa';
	       	AddressUpdate.alreadyUpdated = true;
	       	
	       	update c;
	       	system.assertEquals(a.BillingPostalCode, c.MailingPostalCode);
	       	//test.stopTest();
    	}
    	
    	static testMethod void UpdateAccountTest(){
    		Account b = new Account(Name ='TestAccount2', BillingPostalCode = '5678');
    		insert b;
		   	Contact d = new Contact(FirstName = 'C', LastName = 'D', AccountId = b.Id);
		   	insert d;
		   	AddressUpdate.alreadyUpdated = true;
		   	
		   	b.BillingPostalCode = '7890';
	       	
	       	update b; 	
	       	test.startTest(); 	       	
	       	system.assertEquals(b.BillingPostalCode, d.MailingPostalCode); 
	      	test.stopTest();
       	  	
 
    }
}