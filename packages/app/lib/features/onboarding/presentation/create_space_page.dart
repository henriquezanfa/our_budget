import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';

class CreateSpacePage extends StatefulWidget {
  const CreateSpacePage({super.key});

  @override
  State<CreateSpacePage> createState() => _CreateSpacePageState();
}

class _CreateSpacePageState extends State<CreateSpacePage> {
  late final TextEditingController _spaceNameController;
  late final FocusNode _spaceNameFocusNode;

  @override
  void initState() {
    super.initState();
    _spaceNameController = TextEditingController();
    _spaceNameFocusNode = FocusNode();

    _spaceNameFocusNode.requestFocus();
    _spaceNameController.addListener(() {
      setState(() {});
    });
  }

  bool get _isFormValid =>
      _spaceNameController.text.isNotEmpty &&
      _spaceNameController.text.length > 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Text(
                    'Step 1 - Create a space',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'The space is where you and your partner will manage your budget together.\nGive it a name and you\'re ready to go!',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: _spaceNameFocusNode,
              controller: _spaceNameController,
              decoration: const InputDecoration(
                labelText: 'Space name',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                        context.push(
                          '${OBRoutes.onboarding}/${OBRoutes.createBankAccounts}',
                        );
                      }
                    : null,
                child: const Text('Create space'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
