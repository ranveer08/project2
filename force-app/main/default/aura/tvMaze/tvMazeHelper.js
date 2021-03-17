({
	searchKeyHelper : function(component, event, helper) {
        let searchInput = component.get('v.search');
        let action = component.get('c.showMapHelper');
        action.setParams({'showStatus':searchInput.replace(/\s/g, '%20')});
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state === 'SUCCESS'){
                component.set('v.result',response.getReturnValue());
            }else{
                let errors = response.getError();
                console.error(errors);
            }
        });
		$A.enqueueAction(action);
	},
    saveHelper: function(component, event) {
        let showOb = event.getSource().get("v.value");
        let action = component.get("c.insertShow");
        action.setParams({"shows": showOb});
        action.setCallback(this, function(response){
            let state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.id",response.getReturnValue());
            }
        })
        $A.enqueueAction(action);
    }
})