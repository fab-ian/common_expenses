var set_item_user_autocomplete = function(field_id, tmp_id, item_id){
  var user_options = {
    url: "/api/users/"+ item_id +"/available_users_item",

    getValue: "name",

    list: {
      maxNumberOfElements: 6,
      match: { enabled: true },
      sort: { enabled: true },
      onSelectItemEvent: function() {
        var value = $(field_id).getSelectedItemData().id;
        $(tmp_id).val(value).trigger("change");
      }
    },

    template: {
      type: "iconLeft",
      fields: { iconSrc: "image" }
    }
  };

  $(field_id).easyAutocomplete(user_options);
};
