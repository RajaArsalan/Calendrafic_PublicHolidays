({
    validateID : function(component, event, helper) {

        let myId = component.get('v.SAnumb');
        if(myId != undefined && myId != null && myId != '' && !isNaN(myId) ){
            console.log('texst' + myId);
            let Idvals = myId.split("");
            let newval = Idvals.map(function(current,index,array){ 
                if(index % 2 == 0){
                    return current;
                }
                else{
                    let tempSum = current * 2;
                    if(tempSum> 9){
                        tempSum = tempSum.toString().split('').map(Number).reduce(function (a, b) {
                            tempSum = a + b;
                            return tempSum;}, 0);
                        return tempSum;
                    }
                    return current *2;
                }
            })
            const initialValue = 0;
            const sumWithInitial = newval.map(Number).reduce((previousValue, currentValue) => previousValue + currentValue,
                initialValue
            );
            console.log(newval);
            console.log(sumWithInitial);
            if(sumWithInitial % 10 == 0)
            {
                console.log('Number Is Valid');
                component.set('v.notValid', false);
                component.set('v.buttonActive',false);
            }
            else{
                console.log('Invalid');
                component.set('v.notValid', true);
                component.set('v.buttonActive',true);
                component.set('v.hasData', false);
                
            }           
        }              
        	else if(isNaN(myId)==true){
               component.set('v.notValid', true); 
            }
            else{
            component.set('v.notValid', false);
            component.set('v.buttonActive',true);
            component.set('v.hasData', false);
        }
        

    },
    setupDataTable: function (component) {
        console.log('in setup');
        component.set('v.columns', [
            {label: 'Holiday Name', fieldName: 'holidayName', type: 'text', wrapText: true,},
            {label: 'Description', fieldName: 'description', type: 'text', wrapText: true, initialWidth: 720 },
            {label: 'Holiday Date', fieldName: 'holidayDate',  type: 'text'}
        ]);
    },
    
    getData: function (component) {
        
        var action = component.get("c.getHolidays");	
        action.setParams({ "numberId" : component.get("v.SAnumb") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("SUCCESS");
                var holidaysWrapper = response.getReturnValue();
                
                component.set('v.allData', holidaysWrapper);
                component.set('v.filteredData', holidaysWrapper);
                this.preparePagination(component, holidaysWrapper);
                component.set('v.hasData', true);
                
            }
            else if (state === "INCOMPLETE") {
                console.log("Could Not get DATA");
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        
        $A.enqueueAction(action);
        
        
    },
    
    preparePagination: function (component, holidaysWrapper) {
        let countTotalPage = Math.ceil(holidaysWrapper.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
        component.set("v.totalPages", totalPage);
        component.set("v.currentPageNumber", 1);
        this.setPageDataAsPerPagination(component);
    },
    
    setPageDataAsPerPagination: function(component) {
        let data = [];
        let pageNumber = component.get("v.currentPageNumber");
        let pageSize = component.get("v.pageSize");
        let filteredData = component.get('v.filteredData');
        let x = (pageNumber - 1) * pageSize;
        for (; x < (pageNumber) * pageSize; x++){
            if (filteredData[x]) {
                data.push(filteredData[x]);
            }
        }
        component.set("v.tableData", data);
    },
    
})