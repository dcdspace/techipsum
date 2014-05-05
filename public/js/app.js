$(document).ready(function() {
    // Generate a simple captcha
    $('input[type="radio"]:checked').parent('label').addClass('active');
    $("#progressbar").hide();
    var randomwords;
    var new_div = $('<input id="newwordsinput" type="text" autocomplete="off" class="form-control" name="words" placeholder="enter a number between 5 and 20">').hide();
    $('#staticwords').append(new_div);

    var new_div1 = $('<input id="newsentenceinput" type="text" autocomplete="off" class="form-control" name="sentences" placeholder="enter a number between 10 and 25">').hide();
    $('#staticsentence').append(new_div1);
    $("#myform").submit(function (e) {
        if ($('#myform').data('bootstrapValidator').isValid()){
            $("#progressbar").show();
            $('#progressbar').append('<div class="progress-bar progress-bar-success"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>');
        }
    });
//word numbers
    $("#myform input[name='randomwords']").click(function(){
        if ($("input[name='randomwords']:checked").val() == "random") {
            $('#wordstatic').removeClass('active');
            $('#wordrand').addClass('active');
            //alert('Random Words');
            randomwords = true;
            var bootstrapValidator = $('#myform').data('bootstrapValidator');
            bootstrapValidator.enableFieldValidators('words', false);
            new_div.slideUp();
        }
        else {
            $('#wordrand').removeClass('active');
            $('#wordstatic').addClass('active');
            //alert('Static words');
            randomwords = false;
            var bootstrapValidator = $('#myform').data('bootstrapValidator');
            bootstrapValidator.enableFieldValidators('words', true);
            $('#newwordsinput').val('');
            new_div.slideDown();


        }
    });
//sentence numbers
    $("#myform input[name='randomsentence']").click(function(){

        if ($("input[name='randomsentence']:checked").val() == "random") {
            $('#sentencestatic').removeClass('active');
            $('#sentencerand').addClass('active');
            new_div1.slideUp();
            //alert('Random Words');
            randomwords = true;
            var bootstrapValidator = $('#myform').data('bootstrapValidator');
            bootstrapValidator.enableFieldValidators('sentences', false);

        }
        else {
            $('#sentencerand').removeClass('active');
            $('#sentencestatic').addClass('active');
            //alert('Static words');
            randomwords = false;
            var bootstrapValidator = $('#myform').data('bootstrapValidator');
            bootstrapValidator.enableFieldValidators('sentences', true);
            $('#newsentenceinput').val('');
            new_div1.slideDown();

        }
    });

    $('#myform').bootstrapValidator({
        live: 'enabled',
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            paragraphs: {
                message: 'Enter a number between 1 and 12',
                validators: {
                    notEmpty: {
                        message: 'Must not be empty'
                    },
                    digits: {
                        returnValue: true,
                        message: 'Must be a number'
                    },
                    between: {
                        min: 1,
                        max: 12,
                        message: 'Number must be between 1 and 12'
                    }
                }
            },

            words: {
                message: 'Enter a number between 5 and 20',
                enabled: false,
                validators: {
                    notEmpty: {
                        message: 'Must not be empty'
                    },
                    digits: {
                        returnValue: true,
                        message: 'Must be a number'
                    },
                    between: {
                        min: 5,
                        max: 20,
                        message: 'Number must be between 5 and 20'
                    }
                }
            },
            sentences: {
                message: 'Enter a number between 10 and 25',
                enabled: false,
                validators: {
                    notEmpty: {
                        message: 'Must not be empty'
                    },
                    digits: {
                        returnValue: true,
                        message: 'Must be a number'
                    },
                    between: {
                        min: 10,
                        max: 25,
                        message: 'Number must be between 10 and 25'
                    }
                }
            }
        }

    });
});