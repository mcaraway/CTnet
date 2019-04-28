/**
 * A wrapper for a query and a table visualization.
 * The object only requests 1 page + 1 row at a time, by default, in order
 * to minimize the amount of data held locally.
 * Table sorting and pagination is executed by issuing
 * additional requests with appropriate query parameters.
 * E.g., for getting the data sorted by column 'A' the following query is
 * attached to the request: 'tq=order by A'.
 *
 * Note: Discards query strings set by the user on the query object using
 * google.visualization.Query#setQuery.
 *
 * DISCLAIMER: This is an example code which you can copy and change as
 * required. It is used with the google visualization API table visualization
 * which is assumed to be loaded to the page. For more info see:
 * https://developers.google.com/chart/interactive/docs/gallery/table
 * https://developers.google.com/chart/interactive/docs/reference#Query
 */

/**
 * Constructs a new table query wrapper for the specified query, container
 * and tableOptions.
 *
 * Note: The wrapper clones the options object to adjust some of its properties.
 * In particular:
 *         sort {string} set to 'event'.
 *         page {string} set to 'event'.
 *         pageSize {Number} If number <= 0 set to 10.
 *         showRowNumber {boolean} set to true.
 *         firstRowNumber {number} set according to the current page.
 *         sortAscending {boolean} set according to the current sort.
 *         sortColumn {number} set according to the given sort.
 * @constructor
 */
var TimelineQueryWrapper = function(dataSourceUrl, updateUrl, lines) {
	this.dataSourceUrl = dataSourceUrl;
	this.updateUrl = updateUrl;

	var groups = new Array();
	
	lines.forEach(function(item, index){
		groups.push({id:item.id, content: item.name});
	});
	curr = new Date();
    var first = curr.getDate() - curr.getDay();
    start = new Date(curr.setDate(first));
    end = new Date (1000 * 60 * 60 * 24 * 7 + start.valueOf());
	var options = {
		width : "100%",
		start : start,
		end : end,
		editable : true,
		margin : 5, // minimal margin between events
		showMajorLabels : true,
		selectable : true,
		orientation : 'top',
		timeAxis : {
			scale : 'day',
			step : 1,
		stackSubgroups : true
		},

		onMove : function(item, callback) {
			var currentItem = item;
			if (item.className == "Line0") {
				currentItem.className = "Line" + item.group;
				currentItem.editable = true;
				$.ajax({
					url : "/production_events/build/" + item.id,
					type : 'POST',
					data : {
						id : item.id,
						group : item.group,
						start : item.start,
						end : item.end
					},
					success : function(response) {
						dataSet = timeline.itemsData.getDataSet();
						newItem = {id: response.id, 
							content : currentItem.content,
							start : currentItem.start,
							end : currentItem.end,
							group : currentItem.group,
							className : currentItem.className};
						dataSet.remove (currentItem.id)
						dataSet.add(newItem);
					}
				});
				callback(item);
				// send back item as confirmation (can be changed)

			} else {
				item.className = "Line" + item.group;
				$.ajax({
					url : "/production_events/update_ajax/" + item.id,
					type : 'PUT',
					data : {
						production_event : {
							id : item.id,
							start : item.start,
							end : item.end,
							group : item.group,
							className : item.className
						}
					},
					success : function(response) {
						//...
					}
				});
				callback(item);
				// send back item as confirmation (can be changed)

			}
		}
	};
	var container = document.getElementById('mytimeline');
	var data = new vis.DataSet();
	timeline = new vis.Timeline(container, data, groups, options);

	container.addEventListener("dragover", function(e) {
		e.preventDefault();
	});
	container.addEventListener("dragenter", function(e) {
		e.preventDefault();
	});
	container.addEventListener("drop", function(e) {
		e.preventDefault();
	});
};

TimelineQueryWrapper.prototype.addItem = function(item) {
	timeline.itemsData.getDataSet().add(item);
	// data.add(item);
	// timeline.setItems(data);
	// timeline.redraw();
};

/**
 * Sends the query and upon its return draws the Table visualization in the
 * container. If the query refresh interval is set then the visualization will
 * be redrawn upon each refresh.
 */
TimelineQueryWrapper.prototype.sendAndDraw = function() {
	var self = this;
	$.ajax({
		url : this.dataSourceUrl,
		dataType : "json",
		beforeSend : function(xhr) {
			$('#loadingDiv').show();
		},
		done : function(response) {
			$('#loadingDiv').hide();
		},
		success : function(result) {
			$('#loadingDiv').hide();
			TimelineQueryWrapper.draw(result, this.updateUrl);
		},
		failure : function(result) {
			$('#loadingDiv').hide();
			$('#count').html = result;
		}
	});
};

/** Handles the query response after a send returned by the data source. */
TimelineQueryWrapper.draw = function(dataJson, updateUrl) {

	// Create and populate a data table.
	dataJson.forEach(function(item, index) {
		if (item.group != undefined) {
			data.add({
				id : item.id,
				content : item.content,
				start : new Date(item.start),
				end : new Date(item.end),
				group : item.group,
				className : item.className
			});
		} else {
			data.add({
				id : item.id,
				content : item.monum,
				start : new Date(item.dateScheduled),
				end : new Date(1 * 24 * 60 * 60 * 1000 + (new Date(item.dateScheduled)).valueOf()),
				group : 0,
				className : "Line0"
			});
		}
	});
	timeline.setItems(data);
};

/** Performs a shallow clone of the given object. */
TimelineQueryWrapper.clone = function(obj) {
	var newObj = {};
	for (var key in obj) {
		newObj[key] = obj[key];
	}
	return newObj;
};

TimelineQueryWrapper.add = function(obj) {
	var range = timeline.getVisibleChartRange();
	var start = new Date((range.start.valueOf() + range.end.valueOf()) / 2);
	var content = document.getElementById("txtContent").value;

	timeline.addItem({
		'start' : start,
		'content' : content
	});

	var count = data.getNumberOfRows();
	timeline.setSelection([{
		'row' : count - 1
	}]);
}; 