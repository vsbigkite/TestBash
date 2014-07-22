trigger AccountsWithoutContactsTriggger on Opportunity (before insert, before update) {
	List<Opportunity> oOpportiunities = new List<Opportunity>();
	List<Contact> cAccounts = [select id, accountid from Contact]; 
	set<id> cAccountsSet = new set<id>();
	for(Contact c:cAccounts){
		cAccountsSet.add(c.accountId);
	}
	for(Opportunity oOpportiunity:trigger.new){
		if(oOpportiunity.accountid != null){
			for(integer i = 0; i<cAccounts.size(); i++)
				if(!cAccountsSet.contains(oOpportiunity.accountid))
					oOpportiunity.addError('There is no contact associated wiht the selected Account!');
			}
		}
	}