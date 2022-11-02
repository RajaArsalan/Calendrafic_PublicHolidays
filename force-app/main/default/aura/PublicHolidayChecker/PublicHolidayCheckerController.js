({
    
    onBlur: function(component, event, helper) {
 		helper.validateID(component, event, helper);
    },
    Search: function(component, event, helper) {
        console.log('in search');
         helper.setupDataTable(component);
        helper.getData(component);
    },
 
    onNext: function(component, event, helper) {        
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber + 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onPrev: function(component, event, helper) {        
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber - 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onFirst: function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.setPageDataAsPerPagination(component);
    },
     
    onLast: function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPageDataAsPerPagination(component);
    },
    
    checkValidity: function(component, event, helper) {  
        window.setTimeout(function(){
            helper.validateID(component, event, helper);
        },2000);
    }

})