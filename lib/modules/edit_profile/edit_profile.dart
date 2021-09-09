import 'package:flutter/material.dart';
import 'package:social_media_application/cubit/cubit.dart';
import 'package:social_media_application/layout/layout.dart';
import 'package:social_media_application/shared/components/widgets/rounded_input_field.dart';
import 'package:social_media_application/shared/constants.dart';
import 'package:social_media_application/shared/styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var c = AppCubit.get(context);

    nameController.text = c.model.name;
    bioController.text = c.model.bio;
    phoneController.text = c.model.phone;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'edit profile'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (c.profileImage != null)
                c.uploadProfileImage(
                  name: nameController.text,
                  phone: phoneController.text,
                  bio: bioController.text,
                );
              if (c.coverImage != null)
                c.uploadCoverImage(
                  name: nameController.text,
                  phone: phoneController.text,
                  bio: bioController.text,
                );
              c.updateUser(
                name: nameController.text,
                phone: phoneController.text,
                bio: bioController.text,
                cover: c.coverImage.path,
                image: c.profileImage.path,
              );
            },
            child: Text(
              'Update'.toUpperCase(),
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: OutlinedButton(
                onPressed: () {
                  c.getProfileImage();
                },
                child: Row(
                  children: [
                    Text(
                      'change profile PIC'.toUpperCase(),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: kPrimaryColor,
                          ),
                    ),
                    Spacer(),
                    Icon(
                      IconBroken.Edit,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: OutlinedButton(
                onPressed: () {
                  c.getCoverImage();
                },
                child: Row(
                  children: [
                    Text(
                      'change profile cover'.toUpperCase(),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: kPrimaryColor,
                          ),
                    ),
                    Spacer(),
                    Icon(
                      IconBroken.Edit,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 75.0,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: RoundedInputField(
                  hintText: 'name change',
                  icon: IconBroken.Profile,
                  controller: nameController,
                  onSubmit: (string) {},
                ),
              ),
            ),
            SizedBox(
              height: 75.0,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0,),
                child: RoundedInputField(
                  hintText: 'bio change',
                  icon: IconBroken.Info_Circle,
                  controller: bioController,
                  onSubmit: (string){},
                ),
              ),
            ),
            SizedBox(
              height: 75.0,
              width: double.infinity,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0,),
                child: RoundedInputField(
                  hintText: 'phone',
                  icon: Icons.phone,
                  controller: phoneController,
                  onSubmit: (string){},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
